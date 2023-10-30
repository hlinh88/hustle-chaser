//
//  ExpenseViewModel.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 25/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct ExpenseViewModel {
    let useCase: ExpenseUseCaseType
    let navigator: ExpenseNavigatorType
}

extension ExpenseViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
        let backTrigger: Driver<Void>
        let saveTrigger: Driver<NewExpense>
        let sourceTrigger: Driver<String>
        let amountTrigger: Driver<String>
        let selectColorTrigger: Driver<[Int]>
    }

    struct Output {
        let colors: Driver<[Int]>
        let saveExpense: Driver<Void>
        let source: Driver<String>
        let amount: Driver<Int>
    }

    func transform(_ input: ExpenseViewModel.Input, disposeBag: DisposeBag) -> ExpenseViewModel.Output {

        input.backTrigger
            .drive(onNext: navigator.backToHome)
            .disposed(by: disposeBag)

        let colors = input.selectColorTrigger
            .map { colors in
                return colors
            }
            .asDriver(onErrorJustReturn: [])

        let saveExpense = input.saveTrigger
            .flatMapLatest { thisExpense in
                return self.useCase.saveExpense(thisExpense: thisExpense)
                    .asDriver(onErrorDriveWith: .empty())
            }

        let source = input.sourceTrigger
            .map { source in
                return source
            }
            .startWith(Constants.emptyString)
            .asDriver(onErrorJustReturn: Constants.emptyString)

        let amount = input.amountTrigger
            .map { amount in
                guard let convertedAmount = Int(amount) else { return 0 }
                return convertedAmount
            }
            .asDriver(onErrorJustReturn: 0)

        return Output(colors: colors, saveExpense: saveExpense, source: source, amount: amount)
    }
}

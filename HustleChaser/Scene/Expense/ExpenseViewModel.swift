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
    }

    struct Output {
        let saveExpense: Driver<Void>
        let source: Driver<String>
        let amount: Driver<Int>
    }

    func transform(_ input: ExpenseViewModel.Input, disposeBag: DisposeBag) -> ExpenseViewModel.Output {

        input.backTrigger
            .drive(onNext: navigator.backToHome)
            .disposed(by: disposeBag)

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

        return Output(saveExpense: saveExpense, source: source, amount: amount)
    }
}

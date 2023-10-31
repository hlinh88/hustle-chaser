//
//  EarningsViewModel.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 30/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct EarningsViewModel {
    let useCase: EarningsUseCaseType
    let navigator: EarningsNavigatorType
}

extension EarningsViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let backTrigger: Driver<Void>
        let deleteTrigger: Driver<Void>
    }

    struct Output {
        let earnings: Driver<[NewExpense]>
        let delete: Driver<Void>
    }

    func transform(_ input: EarningsViewModel.Input, disposeBag: DisposeBag) -> EarningsViewModel.Output {
        input.backTrigger
            .drive(onNext: navigator.backToHome)
            .disposed(by: disposeBag)
        
        let earnings = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getExpenses(type: true)
                    .asDriver(onErrorJustReturn: [])
            }

        let delete = input.deleteTrigger
            .flatMapLatest {
                return self.useCase.deleteExpenses()
                    .asDriver(onErrorJustReturn: ())
            }

        return Output(earnings: earnings, delete: delete)
    }
}

//
//  TransactionsViewModel.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct TransactionsViewModel {
    let useCase: TransactionsUseCaseType
    let navigator: TransactionsNavigatorType
}

extension TransactionsViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let backTrigger: Driver<Void>
    }

    struct Output {
        let transactions: Driver<[NewExpense]>
    }

    func transform(_ input: TransactionsViewModel.Input, disposeBag: DisposeBag) -> TransactionsViewModel.Output {
        input.backTrigger
            .drive(onNext: navigator.backToHome)
            .disposed(by: disposeBag)

        let transactions = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getExpenses(type: false)
                    .asDriver(onErrorJustReturn: [])
            }

        return Output(transactions: transactions)
    }
}

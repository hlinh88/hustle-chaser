//
//  HomeViewModel.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct HomeViewModel {
    let useCase: HomeUseCaseType
    let navigator: HomeNavigatorType
}

extension HomeViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
        let selectProfileTrigger: Driver<Void>
        let seeAllEarningsTrigger: Driver<Void>
        let seeAllTransactionsTrigger: Driver<Void>
    }

    struct Output {
        let earnings: Driver<[NewExpense]>
        let transactions: Driver<[NewExpense]>
    }

    func transform(_ input: HomeViewModel.Input, disposeBag: DisposeBag) -> HomeViewModel.Output {

        let earnings = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getExpenses(type: true)
                    .asDriver(onErrorJustReturn: [])
            }

        input.selectProfileTrigger
            .drive(onNext: { _ in
                self.navigator.goToNewExpense()
            })
            .disposed(by: disposeBag)


        input.seeAllEarningsTrigger
            .drive(onNext: { _ in
                self.navigator.goToEarnings()
            })
            .disposed(by: disposeBag)

        input.seeAllTransactionsTrigger
            .drive(onNext: { _ in
                self.navigator.goToTransactions()
            })
            .disposed(by: disposeBag)

        let transactions = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getExpenses(type: false)
                    .asDriver(onErrorJustReturn: [])
            }

        return Output(earnings: earnings, transactions: transactions)
    }
}

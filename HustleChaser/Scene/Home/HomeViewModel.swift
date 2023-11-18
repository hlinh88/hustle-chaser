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
        let selectNewExpenseTrigger: Driver<Void>
        let seeAllEarningsTrigger: Driver<Void>
        let seeAllTransactionsTrigger: Driver<Void>
        let seeAllSavingsTrigger: Driver<Void>
        let profileTrigger: Driver<Void>
    }

    struct Output {
        let earnings: Driver<[NewExpense]>
        let transactions: Driver<[NewExpense]>
        let user: Driver<User>
        let savings: Driver<[NewSaving]>
    }

    func transform(_ input: HomeViewModel.Input, disposeBag: DisposeBag) -> HomeViewModel.Output {

        let earnings = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getExpenses(type: true)
                    .asDriver(onErrorJustReturn: [])
            }

        let user = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getUser()
                    .asDriver(onErrorJustReturn: User(id: "currentUser",
                                                      balance: 0,
                                                      name: Constants.emptyString))
            }

        let savings = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getSavings()
                    .asDriver(onErrorJustReturn: [])
            }

        input.selectNewExpenseTrigger
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

        input.seeAllSavingsTrigger
            .drive(onNext: { _ in
                self.navigator.goToSavings()
            })
            .disposed(by: disposeBag)

        input.profileTrigger
            .drive(onNext: { _ in
                self.navigator.goToProfile()
            })
            .disposed(by: disposeBag)

        let transactions = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getExpenses(type: false)
                    .asDriver(onErrorJustReturn: [])
            }

        return Output(earnings: earnings,
                      transactions: transactions,
                      user: user,
                      savings: savings)
    }
}

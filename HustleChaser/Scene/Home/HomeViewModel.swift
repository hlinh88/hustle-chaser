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
        let deleteTrigger: Driver<Void>
    }

    struct Output {
        let expenses: Driver<[NewExpense]>
        let deleteExpense: Driver<Void>
    }

    func transform(_ input: HomeViewModel.Input, disposeBag: DisposeBag) -> HomeViewModel.Output {

        let expenses = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getExpenses()
                    .asDriver(onErrorJustReturn: [])
            }

        input.selectProfileTrigger
            .drive(onNext: { _ in
                self.navigator.goToNewExpense()
            })
            .disposed(by: disposeBag)

        let deleteExpense = input.deleteTrigger
            .flatMapLatest { id in
                return self.useCase.deleteExpenses()
                    .asDriver(onErrorDriveWith: .empty())
            }

        return Output(expenses: expenses, deleteExpense: deleteExpense)
    }
}

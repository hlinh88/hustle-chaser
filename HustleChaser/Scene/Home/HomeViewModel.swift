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
    }

    struct Output {
        let expenses: Driver<[NewExpense]>
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

        return Output(expenses: expenses)
    }
}

//
//  SavingsViewModel.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct SavingsViewModel {
    let useCase: SavingsUseCaseType
    let navigator: SavingsNavigatorType
}

extension SavingsViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let backTrigger: Driver<Void>
        let newSavingTrigger: Driver<Void>
    }

    struct Output {
        let savings: Driver<[NewSaving]>
    }

    func transform(_ input: SavingsViewModel.Input, disposeBag: DisposeBag) -> SavingsViewModel.Output {
        input.backTrigger
            .drive(onNext: navigator.backToHome)
            .disposed(by: disposeBag)

        let savings = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getSavings()
                    .asDriver(onErrorJustReturn: [])
            }

        input.newSavingTrigger
            .drive(onNext: navigator.goToNewSaving)
            .disposed(by: disposeBag)

        return Output(savings: savings)
    }
}

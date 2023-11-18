//
//  NewSavingViewModel.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 2/11/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct NewSavingViewModel {
    let useCase: NewSavingUseCaseType
    let navigator: NewSavingNavigatorType
}

extension NewSavingViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
        let backTrigger: Driver<Void>
        let saveTrigger: Driver<NewSaving>
        let nameTrigger: Driver<String>
        let currentAmountTrigger: Driver<String>
        let targetAmountTrigger: Driver<String>
        let daysLeftTrigger: Driver<String>
    }

    struct Output {
        let saveSaving: Driver<Void>
        let name: Driver<String>
        let current: Driver<Int>
        let target: Driver<Int>
        let daysLeft: Driver<Int>
    }

    func transform(_ input: NewSavingViewModel.Input, disposeBag: DisposeBag) -> NewSavingViewModel.Output {

        input.backTrigger
            .drive(onNext: navigator.backToHome)
            .disposed(by: disposeBag)

        let saveSaving = input.saveTrigger
            .flatMapLatest { thisSaving in
                return self.useCase.saveSaving(thisSaving: thisSaving)
                    .asDriver(onErrorDriveWith: .empty())
            }

        let name = input.nameTrigger
            .map { name in
                return name
            }
            .startWith(Constants.emptyString)
            .asDriver(onErrorJustReturn: Constants.emptyString)

        let current = input.currentAmountTrigger
            .map { amount in
                guard let convertedAmount = Int(amount) else { return 0 }
                return convertedAmount
            }
            .asDriver(onErrorJustReturn: 0)

        let target = input.targetAmountTrigger
            .map { amount in
                guard let convertedAmount = Int(amount) else { return 0 }
                return convertedAmount
            }
            .asDriver(onErrorJustReturn: 0)

        let daysLeft = input.daysLeftTrigger
            .map { amount in
                guard let convertedAmount = Int(amount) else { return 0 }
                return convertedAmount
            }
            .asDriver(onErrorJustReturn: 0)

        return Output(saveSaving: saveSaving,
                      name: name,
                      current: current,
                      target: target,
                      daysLeft: daysLeft)
    }
}

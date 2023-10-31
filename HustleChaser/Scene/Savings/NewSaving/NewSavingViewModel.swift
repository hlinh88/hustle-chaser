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
    }

    struct Output {
    }

    func transform(_ input: NewSavingViewModel.Input, disposeBag: DisposeBag) -> NewSavingViewModel.Output {

        input.backTrigger
            .drive(onNext: navigator.backToHome)
            .disposed(by: disposeBag)

        return Output()
    }
}

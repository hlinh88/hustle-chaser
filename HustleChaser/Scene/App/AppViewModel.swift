//
//  AppViewModel.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct AppViewModel {
    var navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

extension AppViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
    }

    struct Output {

    }

    func transform(_ input: AppViewModel.Input, disposeBag: DisposeBag) -> AppViewModel.Output {

        input.loadTrigger
            .drive(onNext: { _ in
                self.navigator.goToHome()
            })
            .disposed(by: disposeBag)

        return Output()
    }
}

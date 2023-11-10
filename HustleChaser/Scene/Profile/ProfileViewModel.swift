//
//  ProfileViewModel.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 6/11/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct ProfileViewModel {
    let useCase: ProfileUseCaseType
    let navigator: ProfileNavigatorType
}

extension ProfileViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let backTrigger: Driver<Void>
        let nameTrigger: Driver<String>
        let balanceTrigger: Driver<String>
        let saveTrigger: Driver<User>
    }

    struct Output {
        let name: Driver<String>
        let balance: Driver<Int>
        let saveUser: Driver<Void>
    }

    func transform(_ input: ProfileViewModel.Input, disposeBag: DisposeBag) -> ProfileViewModel.Output {
        input.backTrigger
            .drive(onNext: navigator.backToHome)
            .disposed(by: disposeBag)

        let name = input.nameTrigger
            .map { name in
                return name
            }
            .startWith(Constants.emptyString)
            .asDriver(onErrorJustReturn: Constants.emptyString)

        let balance = input.balanceTrigger
            .map { balance in
                guard let convertedBalance = Int(balance) else { return 0 }
                return convertedBalance
            }
            .asDriver(onErrorJustReturn: 0)

        let saveUser = input.saveTrigger
            .flatMapLatest { thisUser in
                return self.useCase.saveUser(thisUser: thisUser)
                    .asDriver(onErrorDriveWith: .empty())
            }


        return Output(name: name, balance: balance, saveUser: saveUser)
    }
}

//
//  HomeUseCase.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeUseCaseType {
    func getExpenses(type: Bool) -> Observable<[NewExpense]>
    func getUser() -> Observable<User>
}

struct HomeUseCase: HomeUseCaseType {
    func getExpenses(type: Bool) -> Observable<[NewExpense]> {
        return CoreDataRepository().getExpenses(type: type)
    }

    func getUser() -> Observable<User> {
        return CoreDataRepository().getUser()
    }
}

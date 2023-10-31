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
    func deleteExpenses() -> Observable<Void>
}

struct HomeUseCase: HomeUseCaseType {
    func getExpenses(type: Bool) -> Observable<[NewExpense]> {
        return CoreDataRepository().getExpenses(type: type)
    }

    func deleteExpenses() -> Observable<Void> {
        return CoreDataRepository().deleteExpenses()
    }
}

//
//  EarningsUseCase.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 30/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol EarningsUseCaseType {
    func getExpenses(type: Bool) -> Observable<[NewExpense]>
    func deleteExpenses() -> Observable<Void>
}

struct EarningsUseCase: EarningsUseCaseType {
    func getExpenses(type: Bool) -> Observable<[NewExpense]> {
        return CoreDataRepository().getExpenses(type: type)
    }

    func deleteExpenses() -> Observable<Void> {
        return CoreDataRepository().deleteExpenses()
    }
}

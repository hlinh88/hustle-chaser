//
//  CoreDataRepository.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 29/10/2023.
//

import Foundation
import RxSwift

protocol CoreDataRepositoryType {
    func getExpenses() -> Observable<[NewExpense]>
    func saveExpense(thisExpense: NewExpense) -> Observable<Void>
    func deleteExpenses() -> Observable<Void>
}

struct CoreDataRepository: CoreDataRepositoryType {
    func getExpenses() -> Observable<[NewExpense]> {
        return CoreDataService.shared.getExpenses()
    }

    func saveExpense(thisExpense: NewExpense) -> Observable<Void> {
        return CoreDataService.shared.saveExpense(thisExpense: thisExpense)
    }

    func deleteExpenses() -> Observable<Void> {
        return CoreDataService.shared.deleteExpenses()
    }
}

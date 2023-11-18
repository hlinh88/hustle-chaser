//
//  CoreDataRepository.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 29/10/2023.
//

import Foundation
import RxSwift

protocol CoreDataRepositoryType {
    func getExpenses(type: Bool) -> Observable<[NewExpense]>
    func saveExpense(thisExpense: NewExpense) -> Observable<Void>
    func deleteExpenseWithId(id: String) -> Observable<Void>
    func deleteExpenses() -> Observable<Void>
    func saveUser(thisUser: User) -> Observable<Void>
    func getUser() -> Observable<User>
    func getSavings() -> Observable<[NewSaving]>
    func saveSaving(thisSaving: NewSaving) -> Observable<Void>
}

struct CoreDataRepository: CoreDataRepositoryType {
    func getExpenses(type: Bool) -> Observable<[NewExpense]> {
        return CoreDataService.shared.getExpenses(type: type)
    }

    func saveExpense(thisExpense: NewExpense) -> Observable<Void> {
        return CoreDataService.shared.saveExpense(thisExpense: thisExpense)
    }

    func deleteExpenseWithId(id: String) -> Observable<Void> {
        return CoreDataService.shared.deleteExpenseWithId(id: id)
    }

    func deleteExpenses() -> Observable<Void> {
        return CoreDataService.shared.deleteExpenses()
    }

    func saveUser(thisUser: User) -> Observable<Void> {
        return CoreDataService.shared.saveUser(thisUser: thisUser)
    }

    func getUser() -> Observable<User> {
        return CoreDataService.shared.getUser()
    }

    func getSavings() -> Observable<[NewSaving]> {
        return CoreDataService.shared.getSavings()
    }

    func saveSaving(thisSaving: NewSaving) -> Observable<Void> {
        return CoreDataService.shared.saveSaving(thisSaving: thisSaving)
    }
}

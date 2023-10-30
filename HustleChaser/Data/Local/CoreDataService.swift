//
//  CoreDataService.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//

import CoreData
import RxSwift

final class CoreDataService {
    static let shared = CoreDataService()

    private init() {}

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HustleChaser")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Load Core Data failed: \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func getExpenses() -> Observable<[NewExpense]> {
        let context = persistentContainer.viewContext
        let request = Expense.fetchRequest()
        return Observable.create { observer in
            do {
                let expenseEntity = try context.fetch(request)
                let expense = expenseEntity.map { exp -> NewExpense in
                    return NewExpense(source: exp.source ?? Constants.emptyString,
                                      amount: Int(exp.amount),
                                      type: exp.type,
                                      color: Int(exp.color))
                }
                observer.onNext(expense)
                observer.onCompleted()
            } catch {
                observer.onError(CoreDataErrorType.getExpensesFailed)
            }
            return Disposables.create()
        }
    }

    func saveExpense(thisExpense: NewExpense) -> Observable<Void> {
        let context = persistentContainer.viewContext
        return Observable.create { observer in
            do {
                Expense(context: context).do {
                    $0.source = thisExpense.source
                    $0.amount = Int64(thisExpense.amount)
                    $0.type = thisExpense.type
                    $0.color = Int64(thisExpense.color)
                }
                try context.save()
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(CoreDataErrorType.saveExpenseFailed)
            }
            return Disposables.create()
        }
    }

    func deleteExpenses() -> Observable<Void> {
        let context = persistentContainer.viewContext
        let request = Expense.fetchRequest()

        return Observable.create { observer in
            do {
                if let expenses = try? context.fetch(request) {
                    for expense in expenses {
                        context.delete(expense)
                        try context.save()
                        observer.onNext(())
                        observer.onCompleted()
                    }
                }
            } catch {
                observer.onError(CoreDataErrorType.deleteExpensesFailed)
            }
            return Disposables.create()
        }
    }

}

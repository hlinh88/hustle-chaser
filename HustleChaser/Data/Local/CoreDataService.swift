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

    func getUser() -> Observable<User> {
        let context = persistentContainer.viewContext
        let request = Person.fetchRequest()
        return Observable.create { observer in
            do {
                let personEntity = try context.fetch(request)
                guard let person = personEntity[safe: 0] else { return Disposables.create() }
                let user = User(id: person.id ?? Constants.emptyString,
                                balance: Int(person.balance),
                                name: person.name ?? Constants.emptyString)
                observer.onNext(user)
                observer.onCompleted()
            } catch {
                observer.onError(CoreDataErrorType.getUserFailed)
            }
            return Disposables.create()
        }
    }

    func saveUser(thisUser: User) -> Observable<Void> {
        let context = persistentContainer.viewContext
        return Observable.create { observer in
            var isExist = false
            do {
                let request = Person.fetchRequest()
                if let persons = try? context.fetch(request) {
                    for person in persons where person.id == "currentUser" {
                        isExist.toggle()
                        if thisUser.balance != 0 {
                            person.balance = Int64(thisUser.balance)
                        }
                        if thisUser.name != "" {
                            person.name = thisUser.name
                        }
                        try context.save()
                        observer.onNext(())
                        observer.onCompleted()
                    }
                }

                if !isExist {
                    Person(context: context).do {
                        $0.id = thisUser.id
                        $0.balance = Int64(thisUser.balance)
                        $0.name = thisUser.name
                    }
                    try context.save()
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch {
                observer.onError(CoreDataErrorType.saveUserFailed)
            }
            return Disposables.create()
        }
    }

    func getExpenses(type: Bool) -> Observable<[NewExpense]> {
        let context = persistentContainer.viewContext
        let request = Expense.fetchRequest()
        return Observable.create { observer in
            do {
                let expenseEntity = try context.fetch(request)
                var expenses: [NewExpense] = []
                _ = expenseEntity.map { exp in
                    if exp.type == type {
                        expenses.append(NewExpense(source: exp.source ?? Constants.emptyString,
                                                   amount: Int(exp.amount),
                                                   type: exp.type,
                                                   color: Int(exp.color),
                                                   desc: exp.desc ?? Constants.emptyString,
                                                   logo: exp.logo ?? Constants.emptyString,
                                                   id: exp.id ?? Constants.emptyString))
                    }
                }
                observer.onNext(expenses)
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
                    $0.desc = thisExpense.desc
                    $0.logo = thisExpense.logo
                    $0.id = thisExpense.id
                }
                let request = Person.fetchRequest()
                if let persons = try? context.fetch(request) {
                    for person in persons where person.id == "currentUser" {
                        person.balance = thisExpense.type == true
                        ? (person.balance + Int64(thisExpense.amount))
                        : (person.balance - Int64(thisExpense.amount))
                        try context.save()
                    }
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

    func deleteExpenseWithId(id: String) -> Observable<Void> {
        let context = persistentContainer.viewContext
        let request = Expense.fetchRequest()

        return Observable.create { observer in
            do {
                if let expenses = try? context.fetch(request) {
                    for expense in expenses where expense.id == id {
                        context.delete(expense)
                        try context.save()
                        observer.onNext(())
                        observer.onCompleted()
                    }
                }
            } catch {
                observer.onError(CoreDataErrorType.deleteExpenseWithIdFailed)
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

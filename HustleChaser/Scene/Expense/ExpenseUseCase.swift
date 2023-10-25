//
//  ExpenseUseCase.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 25/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol ExpenseUseCaseType {
    func saveExpense(thisExpense: NewExpense) -> Observable<Void>
}

struct ExpenseUseCase: ExpenseUseCaseType {
    func saveExpense(thisExpense: NewExpense) -> Observable<Void> {
        return CoreDataRepository().saveExpense(thisExpense: thisExpense)
    }
}

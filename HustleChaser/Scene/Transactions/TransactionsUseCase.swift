//
//  TransactionsUseCase.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol TransactionsUseCaseType {
    func getExpenses(type: Bool) -> Observable<[NewExpense]>
}

struct TransactionsUseCase: TransactionsUseCaseType {
    func getExpenses(type: Bool) -> Observable<[NewExpense]> {
        return CoreDataRepository().getExpenses(type: type)
    }
}


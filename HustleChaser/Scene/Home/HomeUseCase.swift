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
    func getExpenses() -> Observable<[NewExpense]>
}

struct HomeUseCase: HomeUseCaseType {
    func getExpenses() -> Observable<[NewExpense]> {
        return CoreDataRepository().getExpenses()
    }
}

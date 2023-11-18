//
//  SavingsUseCase.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol SavingsUseCaseType {
    func getSavings() -> Observable<[NewSaving]>
}

struct SavingsUseCase: SavingsUseCaseType {
    func getSavings() -> Observable<[NewSaving]> {
        return CoreDataRepository().getSavings()
    }
}

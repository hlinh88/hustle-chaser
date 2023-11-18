//
//  NewSavingUseCase.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 2/11/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol NewSavingUseCaseType {
    func saveSaving(thisSaving: NewSaving) -> Observable<Void>
}

struct NewSavingUseCase: NewSavingUseCaseType {
    func saveSaving(thisSaving: NewSaving) -> Observable<Void> {
        return CoreDataRepository().saveSaving(thisSaving: thisSaving)
    }
}

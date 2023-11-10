//
//  ProfileUseCase.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 6/11/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProfileUseCaseType {
    func saveUser(thisUser: User) -> Observable<Void>
}

struct ProfileUseCase: ProfileUseCaseType {
    func saveUser(thisUser: User) -> Observable<Void> {
        return CoreDataRepository().saveUser(thisUser: thisUser)
    }
}

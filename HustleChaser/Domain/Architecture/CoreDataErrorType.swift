//
//  CoreDataErrorType.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//

import Foundation

enum CoreDataErrorType: Error {
    case getUserFailed
    case saveUserFailed
    case getExpensesFailed
    case saveExpenseFailed
    case deleteExpenseWithIdFailed
    case deleteExpensesFailed
    case checkExistFailed
}

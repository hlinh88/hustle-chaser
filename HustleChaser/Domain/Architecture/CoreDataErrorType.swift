//
//  CoreDataErrorType.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//

import Foundation

enum CoreDataErrorType: Error {
    case getExpensesFailed
    case saveExpenseFailed
    case deleteFailed
    case checkExistFailed
}

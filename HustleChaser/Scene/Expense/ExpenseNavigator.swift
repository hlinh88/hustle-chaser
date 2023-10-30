//
//  ExpenseNavigator.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 25/10/2023.
//

import Foundation
import UIKit

protocol ExpenseNavigatorType {
    func backToHome()
}

struct ExpenseNavigator: ExpenseNavigatorType {
    unowned let navigationController: UINavigationController

    func backToHome() {
        navigationController.popViewController(animated: true)
    }
}

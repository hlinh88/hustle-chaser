//
//  TransactionsNavigator.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//

import UIKit

protocol TransactionsNavigatorType {
    func backToHome()
}

struct TransactionsNavigator: TransactionsNavigatorType {
    unowned let navigationController: UINavigationController

    func backToHome() {
        navigationController.popViewController(animated: true)
    }
}

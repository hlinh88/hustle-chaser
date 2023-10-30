//
//  EarningsNavigator.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 30/10/2023.
//

import UIKit

protocol EarningsNavigatorType {
    func backToHome()
}

struct EarningsNavigator: EarningsNavigatorType {
    unowned let navigationController: UINavigationController

    func backToHome() {
        navigationController.popViewController(animated: true)
    }
}

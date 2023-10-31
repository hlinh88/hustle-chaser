//
//  NewSavingNavigator.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 2/11/2023.
//

import UIKit

protocol NewSavingNavigatorType {
    func backToHome()
}

struct NewSavingNavigator: NewSavingNavigatorType {
    unowned let navigationController: UINavigationController

    func backToHome() {
        navigationController.popViewController(animated: true)
    }
}

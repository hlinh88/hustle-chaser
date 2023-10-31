//
//  ProfileNavigator.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 6/11/2023.
//

import Foundation
import UIKit

protocol ProfileNavigatorType {
    func backToHome()
}

struct ProfileNavigator: ProfileNavigatorType {
    unowned let navigationController: UINavigationController

    func backToHome() {
        navigationController.popViewController(animated: true)
    }
}

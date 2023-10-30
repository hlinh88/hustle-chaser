//
//  AppNavigator.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//

import UIKit

protocol AppNavigatorType {
    func goToHome()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow

    func goToHome() {
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let navigator = HomeNavigator(navigationController: navigationController)
        let useCase = HomeUseCase()
        let viewModel = HomeViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

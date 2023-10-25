//
//  HomeNavigator.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//

import UIKit

protocol HomeNavigatorType {
    func goToNewExpense()
}

struct HomeNavigator: HomeNavigatorType {
    unowned let navigationController: UINavigationController

    func goToNewExpense() {
        let viewController = ExpenseViewController()
        let navigator = ExpenseNavigator(navigationController: navigationController)
        let useCase = ExpenseUseCase()
        let viewModel = ExpenseViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

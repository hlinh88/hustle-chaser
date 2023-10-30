//
//  HomeNavigator.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//

import UIKit

protocol HomeNavigatorType {
    func goToNewExpense()
    func goToEarnings()
    func goToTransactions()
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

    func goToEarnings() {
        let viewController = EarningsViewController()
        let navigator = EarningsNavigator(navigationController: navigationController)
        let useCase = EarningsUseCase()
        let viewModel = EarningsViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToTransactions() {
        let viewController = TransactionsViewController()
        let navigator = TransactionsNavigator(navigationController: navigationController)
        let useCase = TransactionsUseCase()
        let viewModel = TransactionsViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

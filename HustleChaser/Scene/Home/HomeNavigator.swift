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
    func goToSavings()
    func goToProfile()
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

    func goToSavings() {
        let viewController = SavingsViewController()
        let navigator = SavingsNavigator(navigationController: navigationController)
        let useCase = SavingsUseCase()
        let viewModel = SavingsViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToProfile() {
        let viewController = ProfileViewController()
        let navigator = ProfileNavigator(navigationController: navigationController)
        let useCase = ProfileUseCase()
        let viewModel = ProfileViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

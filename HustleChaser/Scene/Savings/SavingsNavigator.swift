//
//  SavingsNavigator.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//

import UIKit

protocol SavingsNavigatorType {
    func backToHome()
    func goToNewSaving()
}

struct SavingsNavigator: SavingsNavigatorType {
    unowned let navigationController: UINavigationController

    func backToHome() {
        navigationController.popViewController(animated: true)
    }

    func goToNewSaving() {
        let viewController = NewSavingViewController()
        let navigator = NewSavingNavigator(navigationController: navigationController)
        let useCase = NewSavingUseCase()
        let viewModel = NewSavingViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

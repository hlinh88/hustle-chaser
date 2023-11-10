//
//  SavingsViewController.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Then

final class SavingsViewController: UIViewController, BindableType {
    @IBOutlet private weak var backButton: UIImageView!

    var viewModel: SavingsViewModel!
    private let disposeBag = DisposeBag()

    private let loadTrigger = PublishSubject<Void>()
    private let backTrigger = PublishSubject<Void>()
    private let newSavingTrigger = PublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func configView() {
        self.do {
            let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButton(_:)))
            $0.backButton.isUserInteractionEnabled = true
            $0.backButton.addGestureRecognizer(backButtonTap)
        }
    }

    func bindViewModel() {
        let input = SavingsViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorDriveWith: .empty()),
            backTrigger: backTrigger.asDriver(onErrorDriveWith: .empty()),
            newSavingTrigger: newSavingTrigger.asDriver(onErrorDriveWith: .empty())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

    }

    @objc private func handleBackButton(_ sender: UITapGestureRecognizer) {
        backTrigger.onNext(())
    }

    @IBAction private func handleNewSavingButton(_ sender: UIButton) {
        newSavingTrigger.onNext(())
    }
}

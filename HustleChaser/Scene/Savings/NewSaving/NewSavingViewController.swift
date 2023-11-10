//
//  NewSavingViewController.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 2/11/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class NewSavingViewController: UIViewController, BindableType {
    @IBOutlet private weak var backButton: UIImageView!

    var viewModel: NewSavingViewModel!
    private let disposeBag = DisposeBag()

    private let backTrigger = PublishSubject<Void>()


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
        let input = NewSavingViewModel.Input(
            loadTrigger: Driver.just(()),
            backTrigger: backTrigger.asDriver(onErrorDriveWith: .empty())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

    }

    @objc private func handleBackButton(_ sender: UITapGestureRecognizer) {
        backTrigger.onNext(())
    }
}

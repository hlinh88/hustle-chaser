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
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var currentAmountTextField: UITextField!
    @IBOutlet private weak var targetAmountTextField: UITextField!
    @IBOutlet private weak var daysTextField: UITextField!
    

    var viewModel: NewSavingViewModel!
    private let disposeBag = DisposeBag()

    private let backTrigger = PublishSubject<Void>()
    private let saveTrigger = PublishSubject<NewSaving>()

    private var name = ""
    private var current = 0
    private var target = 0
    private var daysLeft = 0


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
            backTrigger: backTrigger.asDriver(onErrorDriveWith: .empty()),
            saveTrigger: saveTrigger.asDriver(onErrorDriveWith: .empty()),
            nameTrigger: nameTextField.rx.text.orEmpty.asDriver(),
            currentAmountTrigger: currentAmountTextField.rx.text.orEmpty.asDriver(),
            targetAmountTrigger: targetAmountTextField.rx.text.orEmpty.asDriver(),
            daysLeftTrigger: daysTextField.rx.text.orEmpty.asDriver()
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.saveSaving
            .drive()
            .disposed(by: disposeBag)

        output.name
            .drive(nameBinding)
            .disposed(by: disposeBag)

        output.current
            .drive(currentBinding)
            .disposed(by: disposeBag)

        output.target
            .drive(targetBinding)
            .disposed(by: disposeBag)

        output.daysLeft
            .drive(daysLeftBinding)
            .disposed(by: disposeBag)

    }

    @objc private func handleBackButton(_ sender: UITapGestureRecognizer) {
        backTrigger.onNext(())
    }
    
    @IBAction func handleSaveButton(_ sender: UIButton) {
        let newSaving = NewSaving(name: name,
                                   current: current,
                                   target: target,
                                   days: daysLeft)
        saveTrigger.onNext(newSaving)
        backTrigger.onNext(())
    }
}

extension NewSavingViewController {
    private var nameBinding: Binder<String> {
        return Binder(self) { viewController, name in
            viewController.do {
                $0.name = name
            }
        }
    }

    private var currentBinding: Binder<Int> {
        return Binder(self) { viewController, current in
            viewController.do {
                $0.current = current
            }
        }
    }

    private var targetBinding: Binder<Int> {
        return Binder(self) { viewController, target in
            viewController.do {
                $0.target = target
            }
        }
    }

    private var daysLeftBinding: Binder<Int> {
        return Binder(self) { viewController, daysLeft in
            viewController.do {
                $0.daysLeft = daysLeft
            }
        }
    }

}


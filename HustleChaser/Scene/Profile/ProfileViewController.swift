//
//  ProfileViewController.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 6/11/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: UIViewController, BindableType {
    @IBOutlet private var superView: UIView!
    @IBOutlet private weak var backButton: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var balanceTextField: UITextField!
    
    var viewModel: ProfileViewModel!
    private let disposeBag = DisposeBag()

    private let loadTrigger = PublishSubject<Void>()
    private let backTrigger = PublishSubject<Void>()
    private let saveTrigger = PublishSubject<User>()

    private var name = Constants.emptyString
    private var balance = 0

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
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            $0.superView.addGestureRecognizer(tap)
            let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButton(_:)))
            $0.backButton.isUserInteractionEnabled = true
            $0.backButton.addGestureRecognizer(backButtonTap)
        }
    }

    func bindViewModel() {
        let input = ProfileViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorDriveWith: .empty()),
            backTrigger: backTrigger.asDriver(onErrorDriveWith: .empty()),
            nameTrigger: nameTextField.rx.text.orEmpty.asDriver(),
            balanceTrigger: balanceTextField.rx.text.orEmpty.asDriver(),
            saveTrigger: saveTrigger.asDriver(onErrorDriveWith: .empty())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.name
            .drive(nameBinding)
            .disposed(by: disposeBag)

        output.balance
            .drive(balanceBinding)
            .disposed(by: disposeBag)

        output.saveUser
            .drive()
            .disposed(by: disposeBag)

    }

    @objc private func dismissKeyboard() {
        superView.endEditing(true)
    }

    @objc private func handleBackButton(_ sender: UITapGestureRecognizer) {
        backTrigger.onNext(())
    }
    
    @IBAction func handleSaveButton(_ sender: UIButton) {
        let updateUser = User(id: "currentUser",
                              balance: self.balance,
                              name: self.name)
        saveTrigger.onNext(updateUser)
        backTrigger.onNext(())
    }
}


extension ProfileViewController {
    private var nameBinding: Binder<String> {
        return Binder(self) { viewController, name in
            viewController.do {
                $0.name = name
            }
        }
    }

    private var balanceBinding: Binder<Int> {
        return Binder(self) { viewController, balance in
            viewController.do {
                $0.balance = balance
            }
        }
    }
}

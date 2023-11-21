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
    @IBOutlet weak var savingsTableView: UITableView!
    
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
        loadTrigger.onNext(())
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func configView() {
        self.do {
            $0.savingsTableView.register(cellType: SavingsTableViewCell.self)
            $0.savingsTableView.rowHeight = 250
            $0.savingsTableView.delegate = self
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

        output.savings
            .drive(savingsTableView.rx.items) { tableView, index, saving in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SavingsTableViewCell.self)
                cell.configCell(thisSaving: saving)
                return cell
            }
            .disposed(by: disposeBag)

    }

    @objc private func handleBackButton(_ sender: UITapGestureRecognizer) {
        backTrigger.onNext(())
    }

    @IBAction private func handleNewSavingButton(_ sender: UIButton) {
        newSavingTrigger.onNext(())
    }
}

extension SavingsViewController: UITableViewDelegate {
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal,
                                        title: Constants.emptyString) { (action, view, completionHandler) in
            completionHandler(true)
        }.then {
            $0.image = UIImage(systemName: "trash")
            $0.backgroundColor = UIColor.red
        }

        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}

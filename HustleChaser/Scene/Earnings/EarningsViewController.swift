//
//  EarningsViewController.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 30/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Then

final class EarningsViewController: UIViewController, BindableType {
    @IBOutlet private weak var backButton: UIImageView!
    @IBOutlet private weak var earningsTableView: UITableView!

    var viewModel: EarningsViewModel!
    private let disposeBag = DisposeBag()

    private let loadTrigger = PublishSubject<Void>()
    private let backTrigger = PublishSubject<Void>()
    private let deleteTrigger = PublishSubject<String>()
    private var ids: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        self.do {
            $0.earningsTableView.register(cellType: EarningsTableViewCell.self)
            $0.earningsTableView.delegate = self
            $0.earningsTableView.rowHeight = 100
            let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButton(_:)))
            $0.backButton.isUserInteractionEnabled = true
            $0.backButton.addGestureRecognizer(backButtonTap)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadTrigger.onNext(())
    }

    func bindViewModel() {
        let input = EarningsViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorDriveWith: .empty()),
            backTrigger: backTrigger.asDriver(onErrorDriveWith: .empty()),
            deleteTrigger: deleteTrigger.asDriver(onErrorDriveWith: .empty())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.earnings
            .drive(earningsTableView.rx.items) { tableView, index, earning in
                let indexPath = IndexPath(item: index, section: 0)
                self.ids.append(earning.id)
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EarningsTableViewCell.self)
                cell.configCell(thisEarnings: earning)
                return cell
            }
            .disposed(by: disposeBag)

        output.delete
            .drive()
            .disposed(by: disposeBag)
    }

    @objc private func handleBackButton(_ sender: UITapGestureRecognizer) {
        backTrigger.onNext(())
    }
}

extension EarningsViewController: UITableViewDelegate {
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, 
                                        title: Constants.emptyString) { [unowned self] (action, view, completionHandler) in
            self.deleteTrigger.onNext(self.ids[indexPath.row])
            self.loadTrigger.onNext(())
            completionHandler(true)
        }.then {
            $0.image = UIImage(systemName: "trash")
            $0.backgroundColor = UIColor.red
        }

        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}

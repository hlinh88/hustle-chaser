//
//  TransactionsViewController.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Then

final class TransactionsViewController: UIViewController, BindableType {
    @IBOutlet private weak var transactionsTableView: UITableView!
    @IBOutlet private weak var backButton: UIImageView!

    var viewModel: TransactionsViewModel!
    private let disposeBag = DisposeBag()

    private let loadTrigger = PublishSubject<Void>()
    private let backTrigger = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadTrigger.onNext(())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    private func configView() {
        self.do {
            $0.transactionsTableView.register(cellType: TransactionsTableViewCell.self)
            $0.transactionsTableView.rowHeight = 80
            let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButton(_:)))
            $0.backButton.isUserInteractionEnabled = true
            $0.backButton.addGestureRecognizer(backButtonTap)
        }
    }

    func bindViewModel() {
        let input = TransactionsViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorDriveWith: .empty()),
            backTrigger: backTrigger.asDriver(onErrorDriveWith: .empty())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.transactions
            .drive(transactionsTableView.rx.items) { tableView, index, transaction in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TransactionsTableViewCell.self)
                cell.configCell(thisTransaction: transaction)
                cell.configBackgroundColor()
                return cell
            }
            .disposed(by: disposeBag)

    }

    @objc private func handleBackButton(_ sender: UITapGestureRecognizer) {
        backTrigger.onNext(())
    }
}

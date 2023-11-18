//
//  HomeViewController.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 19/10/2023.
//

import UIKit
import Then
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController, BindableType {
    @IBOutlet private weak var greetingLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var earningsCollectionView: UICollectionView!
    @IBOutlet private weak var savingsCollectionView: UICollectionView!
    @IBOutlet private weak var transactionsTableView: UITableView!
    @IBOutlet private weak var balanceView: UIView!
    @IBOutlet private weak var incomeView: UIView!
    @IBOutlet private weak var incomeLabel: UILabel!
    @IBOutlet private weak var outcomeLabel: UILabel!

    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()

    private let loadTrigger = PublishSubject<Void>()
    private let selectNewExpenseTrigger = PublishSubject<Void>()
    private let seeAllEarningsTrigger = PublishSubject<Void>()
    private let seeAllTransactionsTrigger = PublishSubject<Void>()
    private let seeAllSavingsTrigger = PublishSubject<Void>()
    private let profileTrigger = PublishSubject<Void>()

    private var income = 0
    private var outcome = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTrigger.onNext(())
    }

    private func configView() {
        self.do {
            $0.earningsCollectionView.register(cellType: EarningsCollectionViewCell.self)
            $0.savingsCollectionView.register(cellType: SavingsCollectionViewCell.self)
            $0.savingsCollectionView.delegate = self
            $0.transactionsTableView.register(cellType: TransactionsTableViewCell.self)
            $0.transactionsTableView.rowHeight = 80
            $0.balanceView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
            $0.incomeView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
            let profileTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            $0.profileImageView.isUserInteractionEnabled = true
            $0.profileImageView.addGestureRecognizer(profileTap)
        }
    }

    func bindViewModel() {
        let input = HomeViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorJustReturn: ()),
            selectNewExpenseTrigger: selectNewExpenseTrigger.asDriver(onErrorDriveWith: .empty()),
            seeAllEarningsTrigger: seeAllEarningsTrigger.asDriver(onErrorDriveWith: .empty()),
            seeAllTransactionsTrigger: seeAllTransactionsTrigger.asDriver(onErrorDriveWith: .empty()),
            seeAllSavingsTrigger: seeAllSavingsTrigger.asDriver(onErrorDriveWith: .empty()),
            profileTrigger: profileTrigger.asDriver(onErrorDriveWith: .empty())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.earnings
            .drive(earningsCollectionView.rx.items) { collectionView, row, expense in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: EarningsCollectionViewCell.self)
                cell.configCell(thisExpense: expense)
                return cell
            }
            .disposed(by: disposeBag)

        output.earnings
            .drive(incomeBinding)
            .disposed(by: disposeBag)

        output.transactions
            .drive(transactionsTableView.rx.items) { tableView, index, transaction in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TransactionsTableViewCell.self)
                cell.configCell(thisTransaction: transaction)
                return cell
            }
            .disposed(by: disposeBag)

        output.savings
            .drive(savingsCollectionView.rx.items) { collectionView, row, saving in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SavingsCollectionViewCell.self)
                cell.configCell(thisSaving: saving)
                return cell
            }
            .disposed(by: disposeBag)

        output.transactions
            .drive(outcomeBinding)
            .disposed(by: disposeBag)

        output.user
            .drive(userBinding)
            .disposed(by: disposeBag)
    }

    @IBAction private func handleBalance(_ sender: UIButton) {
        profileTrigger.onNext(())
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        selectNewExpenseTrigger.onNext(())
    }

    @IBAction private func handleEarnings(_ sender: UIButton) {
        seeAllEarningsTrigger.onNext(())
    }

    @IBAction private func handleTransactions(_ sender: UIButton) {
        seeAllTransactionsTrigger.onNext(())
    }
    
    @IBAction private func handleSavings(_ sender: UIButton) {
        seeAllSavingsTrigger.onNext(())
    }
}

extension HomeViewController {
    private var incomeBinding: Binder<[NewExpense]> {
        return Binder(self) { viewController, expenses in
            viewController.income = 0
            _ = expenses.map { expense in
                viewController.do {
                    $0.income += expense.amount
                    $0.incomeLabel.text = "\($0.income.delimiter)₫"
                    $0.incomeLabel.font = UIFont(name: "PlusJakartaSans-Bold", size: 15)
                }
            }
        }
    }

    private var outcomeBinding: Binder<[NewExpense]> {
        return Binder(self) { viewController, expenses in
            viewController.outcome = 0
            _ = expenses.map { expense in
                viewController.do {
                    $0.outcome += expense.amount
                    $0.outcomeLabel.text = "\($0.outcome.delimiter)₫"
                    $0.outcomeLabel.font = UIFont(name: "PlusJakartaSans-Bold", size: 15)
                }
            }
        }
    }

    private var userBinding: Binder<User> {
        return Binder(self) { viewController, user in
            viewController.do {
                $0.usernameLabel.text = user.name
                $0.balanceLabel.text = "VND \(user.balance.delimiter)"
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        if collectionView == self.savingsCollectionView {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }

            let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size, height: Constants.savingsCellHeight)
        }
        return CGSize()
    }
}

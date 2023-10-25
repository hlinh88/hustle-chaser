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
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var earningsCollectionView: UICollectionView!
    @IBOutlet private weak var savingsCollectionView: UICollectionView!
    @IBOutlet private weak var transactionsTableView: UITableView!
    @IBOutlet private weak var balanceView: UIView!
    @IBOutlet private weak var incomeView: UIView!

    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()

    private let loadTrigger = PublishSubject<Void>()
    private let selectProfileTrigger = PublishSubject<Void>()

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
            $0.savingsCollectionView.dataSource = self
            $0.savingsCollectionView.delegate = self
            $0.transactionsTableView.register(cellType: TransactionsTableViewCell.self)
            $0.transactionsTableView.dataSource = self
            $0.transactionsTableView.delegate = self
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
            selectProfileTrigger: selectProfileTrigger.asDriver(onErrorDriveWith: .empty())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.expenses
            .drive(earningsCollectionView.rx.items) { collectionView, row, expense in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: EarningsCollectionViewCell.self)
                cell.configCell(thisExpense: expense)
                return cell
            }
            .disposed(by: disposeBag)

    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        selectProfileTrigger.onNext(())
    }

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SavingsCollectionViewCell.self)
        return cell

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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TransactionsTableViewCell.self)
        return cell
    }
}

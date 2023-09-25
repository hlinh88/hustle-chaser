//
//  HomeViewController.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 19/10/2023.
//

import UIKit
import Then

final class HomeViewController: UIViewController {
    @IBOutlet private weak var earningsCollectionView: UICollectionView!
    @IBOutlet private weak var savingsCollectionView: UICollectionView!
    @IBOutlet private weak var transactionsTableView: UITableView!
    @IBOutlet private weak var balanceView: UIView!
    @IBOutlet private weak var incomeView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        self.do {
            $0.earningsCollectionView.register(cellType: EarningsCollectionViewCell.self)
            $0.earningsCollectionView.dataSource = self
            $0.savingsCollectionView.register(cellType: SavingsCollectionViewCell.self)
            $0.savingsCollectionView.dataSource = self
            $0.savingsCollectionView.delegate = self
            $0.transactionsTableView.register(cellType: TransactionsTableViewCell.self)
            $0.transactionsTableView.dataSource = self
            $0.transactionsTableView.delegate = self
            $0.balanceView.layer.cornerRadius = CGFloat(LayerSettings.radius.rawValue)
            $0.incomeView.layer.cornerRadius = CGFloat(LayerSettings.radius.rawValue)
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.earningsCollectionView {
            return 3
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.earningsCollectionView {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: EarningsCollectionViewCell.self)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SavingsCollectionViewCell.self)
            return cell
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
            return CGSize(width: size, height: LayerSettings.savingsCellHeight.rawValue)
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

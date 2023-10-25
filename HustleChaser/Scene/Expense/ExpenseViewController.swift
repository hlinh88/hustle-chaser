//
//  ExpenseViewController.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 24/10/2023.
//

import UIKit
import Then
import RxSwift
import RxCocoa

final class ExpenseViewController: UIViewController, BindableType {
    @IBOutlet private var superView: UIView!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var backButton: UIImageView!
    @IBOutlet private weak var colorCollectionView: UICollectionView!
    @IBOutlet private weak var sourceTextField: UITextField!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    var viewModel: ExpenseViewModel!
    private let disposeBag = DisposeBag()

    private let backTrigger = PublishSubject<Void>()
    private let saveTrigger = PublishSubject<NewExpense>()
    
    private var source = ""
    private var amount = 0
    private var type = true

    private let colors = [UIColor(named: "customBlue"),
                          UIColor(named: "customGreen"),
                          UIColor(named: "customLavender"),
                          UIColor(named: "customPink"),
                          UIColor(named: "customRed"),
                          UIColor(named: "customYellow")]

    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func configView() {
        self.do {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            $0.superView.addGestureRecognizer(tap)
            $0.colorCollectionView.register(cellType: ExpenseCollectionViewCell.self)
            $0.colorCollectionView.dataSource = self
            $0.colorCollectionView.delegate = self
            let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButton(_:)))
            $0.backButton.isUserInteractionEnabled = true
            $0.backButton.addGestureRecognizer(backButtonTap)
            $0.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        }
    }

    func bindViewModel() {
        let input = ExpenseViewModel.Input(
            loadTrigger: Driver.just(()),
            backTrigger: backTrigger.asDriver(onErrorDriveWith: .empty()),
            saveTrigger: saveTrigger.asDriver(onErrorDriveWith: .empty()),
            sourceTrigger: sourceTextField.rx.text.orEmpty.asDriver(),
            amountTrigger: amountTextField.rx.text.orEmpty.asDriver()
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.saveExpense
            .drive()
            .disposed(by: disposeBag)

        output.source
            .drive(sourceBinding)
            .disposed(by: disposeBag)

        output.amount
            .drive(amountBinding)
            .disposed(by: disposeBag)

    }

    @objc private func dismissKeyboard() {
        superView.endEditing(true)
    }

    @objc private func handleBackButton(_ sender: UITapGestureRecognizer) {
        backTrigger.onNext(())
    }

    @IBAction private func handleSaveButton(_ sender: UIButton) {
        let newExpense = NewExpense(source: source,
                                    amount: amount,
                                    type: type,
                                    color: 0)
        saveTrigger.onNext(newExpense)
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.type = segmentedControl.selectedSegmentIndex == 0 ? true : false
    }
}

extension ExpenseViewController {
    private var sourceBinding: Binder<String> {
        return Binder(self) { viewController, source in
            viewController.do {
                $0.source = source
            }
        }
    }

    private var amountBinding: Binder<Int> {
        return Binder(self) { viewController, amount in
            viewController.do {
                $0.amount = amount
            }
        }
    }
}

extension ExpenseViewController: ExpenseCollectionViewCellDelegate {
    func handleColorTap(sender: UITapGestureRecognizer, selectedIndex: Int) {
        print(selectedIndex)
    }
}


extension ExpenseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ExpenseCollectionViewCell.self)
        cell.configCell(color: colors[indexPath.row] ?? UIColor(),
                        index: indexPath.row)
        return cell
    }
}

extension ExpenseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }

        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}

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
    @IBOutlet private weak var typeSegmented: UISegmentedControl!
    @IBOutlet private weak var iconSegmented: UISegmentedControl!
    @IBOutlet private weak var descTextField: UITextField!

    var viewModel: ExpenseViewModel!
    private let disposeBag = DisposeBag()

    private let backTrigger = PublishSubject<Void>()
    private let saveTrigger = PublishSubject<NewExpense>()
    private let selectColorTrigger = BehaviorSubject<[Int]>(value: [1, 0, 0, 0, 0, 0])

    private var source = ""
    private var amount = 0
    private var type = true
    private var selectedColor = 0
    private var desc = ""
    private var logo = "fork.knife"

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
            $0.colorCollectionView.delegate = self
            let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButton(_:)))
            $0.backButton.isUserInteractionEnabled = true
            $0.backButton.addGestureRecognizer(backButtonTap)
            $0.typeSegmented.addTarget(self, action: #selector(typeSegmentedValueChanged(_:)), for: .valueChanged)
            $0.iconSegmented.addTarget(self, action: #selector(iconSegmentedValueChanged(_:)), for: .valueChanged)
            $0.iconSegmented.isHidden = true
        }
    }

    func bindViewModel() {
        let input = ExpenseViewModel.Input(
            loadTrigger: Driver.just(()),
            backTrigger: backTrigger.asDriver(onErrorDriveWith: .empty()),
            saveTrigger: saveTrigger.asDriver(onErrorDriveWith: .empty()),
            sourceTrigger: sourceTextField.rx.text.orEmpty.asDriver(),
            amountTrigger: amountTextField.rx.text.orEmpty.asDriver(),
            descTrigger: descTextField.rx.text.orEmpty.asDriver(),
            selectColorTrigger: selectColorTrigger.asDriver(onErrorDriveWith: .empty())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.colors
            .drive(colorCollectionView.rx.items) { collectionView, row, selectedIndex in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ExpenseCollectionViewCell.self)
                cell.configCell(selectedIndex: selectedIndex, index: row)
                cell.delegate = self
                return cell
            }
            .disposed(by: disposeBag)

        output.saveExpense
            .drive()
            .disposed(by: disposeBag)

        output.source
            .drive(sourceBinding)
            .disposed(by: disposeBag)

        output.amount
            .drive(amountBinding)
            .disposed(by: disposeBag)

        output.desc
            .drive(descBinding)
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
                                    color: selectedColor,
                                    desc: desc,
                                    logo: logo)
        saveTrigger.onNext(newExpense)
        backTrigger.onNext(())
    }

    @objc private func typeSegmentedValueChanged(_ sender: UISegmentedControl) {
        type = typeSegmented.selectedSegmentIndex == 0 ? true : false
        iconSegmented.isHidden = typeSegmented.selectedSegmentIndex == 0 ? true : false
    }

    @objc private func iconSegmentedValueChanged(_ sender: UISegmentedControl) {
        switch iconSegmented.selectedSegmentIndex {
        case 1:
            self.logo = "cart.fill"
        case 2:
            self.logo = "building.2.fill"
        case 3:
            self.logo = "airplane.departure"
        default:
            self.logo = "fork.knife"
        }
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

    private var descBinding: Binder<String> {
        return Binder(self) { viewController, desc in
            viewController.do {
                $0.desc = desc
            }
        }
    }
}

extension ExpenseViewController: ExpenseCollectionViewCellDelegate {
    func handleColorTap(sender: UITapGestureRecognizer, selectedIndex: Int) {
        self.selectedColor = selectedIndex
        var colors: [Int] = []
        for color in 0..<6 {
            colors.append(color == selectedIndex ? 1 : 0)
        }
        selectColorTrigger.onNext(colors)
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

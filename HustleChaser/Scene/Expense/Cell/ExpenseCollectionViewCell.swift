//
//  ExpenseCollectionViewCell.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 26/10/2023.
//

import UIKit
import Then
import Reusable

protocol ExpenseCollectionViewCellDelegate: AnyObject {
    func handleColorTap(sender: UITapGestureRecognizer, selectedIndex: Int)
}

class ExpenseCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var checkImageView: UIImageView!
    @IBOutlet private weak var expenseColorView: UIView!

    private var index: Int?
    weak var delegate: ExpenseCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(selectedIndex:Int, index: Int) {
        self.do {
            $0.index = index
            $0.expenseColorView.layer.cornerRadius = expenseColorView.frame.size.width / 2
            $0.expenseColorView.clipsToBounds = true
            $0.expenseColorView.backgroundColor = Constants.colors[index]
            $0.checkImageView.isHidden = selectedIndex != 1 ? true : false
            let colorTap = UITapGestureRecognizer(target: self, action: #selector(self.handleColorTap(_:)))
            $0.expenseColorView.addGestureRecognizer(colorTap)
        }
    }

    @objc private func handleColorTap(_ sender: UITapGestureRecognizer) {
        guard let selectedIndex = self.index else { return }
        delegate?.handleColorTap(sender: sender, selectedIndex: selectedIndex)
    }
}

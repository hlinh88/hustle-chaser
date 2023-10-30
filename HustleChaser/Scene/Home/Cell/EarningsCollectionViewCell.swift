//
//  EarningsCollectionViewCell.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 19/10/2023.
//

import UIKit
import Reusable
import Then

class EarningsCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var earningsView: UIView!
    @IBOutlet private weak var symbolView: UIView!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(thisExpense: NewExpense) {
        self.do {
            $0.earningsView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
            $0.earningsView.backgroundColor = Constants.getColor(colorId: thisExpense.color)
            $0.symbolView.layer.cornerRadius = symbolView.frame.size.width / 2
            $0.symbolView.clipsToBounds = true
            $0.symbolLabel.text = String(thisExpense.source[0])
            $0.sourceLabel.text = thisExpense.source
            $0.amountLabel.text = String(thisExpense.amount)
        }
    }
}

//
//  EarningsTableViewCell.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 31/10/2023.
//

import UIKit
import Reusable

class EarningsTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var superView: UIView!
    @IBOutlet private weak var symbolView: UIView!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(thisEarnings: NewExpense) {
        self.do {
            $0.superView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
            $0.superView.backgroundColor = Constants.getColor(colorId: thisEarnings.color)
            $0.symbolView.layer.cornerRadius = symbolView.frame.size.width / 2
            $0.symbolView.clipsToBounds = true
            $0.symbolLabel.text = String(thisEarnings.source[0])
            $0.sourceLabel.text = thisEarnings.source
            $0.amountLabel.text = "+\(thisEarnings.amount.delimiter)₫"
            $0.descLabel.text = thisEarnings.desc
        }
    }

}

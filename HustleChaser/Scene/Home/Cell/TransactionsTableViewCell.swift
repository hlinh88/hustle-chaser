//
//  TransactionsTableViewCell.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 20/10/2023.
//

import UIKit
import Reusable
import Then

class TransactionsTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var transView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(thisTransaction: NewExpense) {
        self.do {
            $0.transView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
            $0.iconImageView.tintColor = Constants.getColor(colorId: thisTransaction.color)
            $0.sourceLabel.text = thisTransaction.source
            $0.amountLabel.text = "-\(thisTransaction.amount.delimiter)₫"
            $0.descriptionLabel.text = thisTransaction.desc
            if let logo = thisTransaction.logo {
                $0.iconImageView.image = UIImage(systemName: logo)
            }
        }
    }

    func configBackgroundColor() {
        transView.do {
            $0.backgroundColor = UIColor.white
        }
    }
}

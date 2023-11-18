//
//  SavingsTableViewCell.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 18/11/2023.
//

import UIKit
import Reusable

class SavingsTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var currentLabel: UILabel!
    @IBOutlet private weak var targetLabel: UILabel!
    @IBOutlet private weak var percentageLabel: UILabel!
    @IBOutlet private weak var daysLeftLabel: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(thisSaving: NewSaving) {
        let percent = Float(thisSaving.current) / Float(thisSaving.target)
        self.do {
            $0.containerView.layer.cornerRadius = 10
            $0.containerView.backgroundColor = Constants.randomColor()
            $0.nameLabel.text = thisSaving.name
            $0.currentLabel.text = "\(thisSaving.current.delimiter)₫"
            $0.targetLabel.text = "of \(thisSaving.target.delimiter)₫"
            $0.percentageLabel.text = "\(String(format: "%.0f", percent * 100))%"
            $0.progressView.setProgress(percent, animated: true)
            $0.daysLeftLabel.text = "\(thisSaving.days) days left"
        }
    }

}

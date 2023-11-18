//
//  SavingsCollectionViewCell.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 19/10/2023.
//

import UIKit
import Reusable

final class SavingsCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var savingsView: UIView!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var targetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }

    private func customizeView() {
        self.do {
            $0.savingsView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
            $0.progressView.progressTintColor = Constants.randomColor()
        }
    }

    func configCell(thisSaving: NewSaving) {
        let percent = Float(thisSaving.current) / Float(thisSaving.target)
        self.do {
            $0.nameLabel.text = thisSaving.name
            $0.targetLabel.text = "\(thisSaving.target.delimiter)₫"
            $0.progressView.setProgress(percent, animated: true)
            $0.progressView.progressTintColor = Constants.randomColor()
        }
    }
}

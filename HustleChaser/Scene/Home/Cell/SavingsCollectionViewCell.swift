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

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }

    private func customizeView() {
        self.do {
            $0.savingsView.layer.cornerRadius = CGFloat(LayerSettings.radius.rawValue)
            $0.progressView.progressTintColor = Constants.randomColor()
        }
    }
}

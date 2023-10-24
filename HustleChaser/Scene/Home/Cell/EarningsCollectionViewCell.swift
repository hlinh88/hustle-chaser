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

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        self.do {
            $0.earningsView.layer.cornerRadius = CGFloat(LayerSettings.radius.rawValue)
            $0.earningsView.backgroundColor = Constants.randomColor()
            $0.symbolView.layer.cornerRadius = symbolView.frame.size.width / 2
            $0.symbolView.clipsToBounds = true
        }
    }
}

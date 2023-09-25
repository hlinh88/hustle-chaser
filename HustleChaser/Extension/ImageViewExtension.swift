//
//  ImageExtension.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 25/9/2023.
//

import UIKit

extension UIImageView {
    func roundCorner() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

//
//  ViewExtension.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 25/9/2023.
//

import UIKit

extension UIView {
    func roundLeftCorners() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.layer.masksToBounds = true
    }

    func roundRightCorners() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.layer.masksToBounds = true
    }
}

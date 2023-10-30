//
//  String+Extension.swift
//  HustleChaser
//
//  Created by Hoang Linh Nguyen on 30/10/2023.
//

import Foundation

extension String {
    public subscript(_ idx: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: idx)]
    }
}

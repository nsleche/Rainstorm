//
//  ReusableCell.swift
//  Rainstorm
//
//  Created by Alves Jorge on 03/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation


protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

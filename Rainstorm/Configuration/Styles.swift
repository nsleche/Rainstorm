//
//  Styles.swift
//  Rainstorm
//
//  Created by Alves Jorge on 02/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

extension UIColor {
    enum Rainstorm {
        static let base = UIColor(red: 0.31, green: 0.72, blue: 0.83, alpha: 1.0)
        static let lightBackgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1.0)
    }
}

extension UIFont {
    enum Rainstorm {
        static let lightRegular = UIFont.systemFont(ofSize: 17, weight: .light)
        static let lightSmall = UIFont.systemFont(ofSize: 15, weight: .light)
        static let heavyLarge = UIFont.systemFont(ofSize: 20, weight: .heavy)
    }
}

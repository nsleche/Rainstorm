//
//  UIImage+Extension.swift
//  Rainstorm
//
//  Created by Alves Jorge on 02/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageForIcon(with name: String) -> UIImage? {
        switch name {
        case "clear-day",
             "clear-night",
             "fog",
             "rain",
             "snow",
             "sleet",
             "wind": return UIImage(named: name)
        case "cloudy",
             "partly-cloudy-day",
             "partly-cloudy-night": return UIImage(named: "cloudy")
        default: return nil
        }
    }
}

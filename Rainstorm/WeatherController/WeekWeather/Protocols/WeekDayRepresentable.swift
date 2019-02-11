//
//  WeekDayRepresentable.swift
//  Rainstorm
//
//  Created by Alves Jorge on 03/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

protocol WeekDayRepresentable {
    
    var day: String { get} 
    
    var date: String { get }
    
    var temperature: String { get }
    
    var windspeed: String { get }
    
    var image: UIImage? { get }
}

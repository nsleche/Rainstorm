//
//  AppCordinator.swift
//  Rainstorm
//
//  Created by Alves Jorge on 30/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func start()
}

final class AppCordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootCoordinator = RootCoordinator(window: window)
        rootCoordinator.start()
    }
}

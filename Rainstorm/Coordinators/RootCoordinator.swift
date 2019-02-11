//
//  RootCoordinator.swift
//  Rainstorm
//
//  Created by Alves Jorge on 30/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

final class RootCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootViewModel = RootViewModel(locationManager: LocationManager(), networkManager: NetworkManager())
        let rootController = RootViewController(rootViewModel: rootViewModel)
        let navigationController = UINavigationController(rootViewController: rootController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
}

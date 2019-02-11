//
//  WeekWeatherTableViewController.swift
//  Rainstorm
//
//  Created by Alves Jorge on 03/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class WeekWeatherTableViewController: UITableViewController {
    
    var weekViewModel: WeekViewModel? {
        didSet {
            print("reloading")
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(WeekCell.self, forCellReuseIdentifier: WeekCell.identifier)
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weekViewModel?.numberOfDays ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekCell.identifier, for: indexPath) as? WeekCell else {
            return UITableViewCell()
        }
        if let viewModel = weekViewModel?.viewModel(for: indexPath.row) {
            cell.configure(with: viewModel)
        }
        return cell
    }
    
}

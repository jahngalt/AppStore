//
//  AppFullScreenController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/23/20.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide lines in tableView
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let cell = UITableViewCell()
            let todayCell = TodayCell()
            cell.addSubview(todayCell)
            todayCell.centerInSuperview(size: .init(width: 250, height: 250))
            cell.selectionStyle = .none
            return cell
        }
        
        
        let cell = AppFullScreenDescriptionCell()
        cell.selectionStyle = .none
        return cell 
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}

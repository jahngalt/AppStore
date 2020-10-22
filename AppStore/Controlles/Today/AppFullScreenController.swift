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
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TodayCell()
        return header
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 450
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppFullScreenDescriptionCell()
        
        return cell 
    }
}

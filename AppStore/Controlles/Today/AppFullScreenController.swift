//
//  AppFullScreenController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/23/20.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    var dismissHandler: (() -> ())?
    
    let headerCellId = "headerCellId"
    let cellId = "cellId"
    var todayItem: TodayItem? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide lines in tableView
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(AppFullScreenHeaderCell.self, forCellReuseIdentifier: headerCellId)
        tableView.register(AppFullScreenDescriptionCell.self, forCellReuseIdentifier: cellId)
        
        tableView.allowsSelection = false
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: headerCellId) as! AppFullScreenHeaderCell
            headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            headerCell.todayCell.todayItem = todayItem
            return headerCell

        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! AppFullScreenDescriptionCell
        return cell 
    }
    
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}

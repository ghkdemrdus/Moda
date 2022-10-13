//
//  MonthlyView.swift
//  moda
//
//  Created by 황득연 on 2022/10/12.
//

import UIKit

class MonthlyView: UITableView {
  
  
  func configureUI {
    let tableView = UITableView()
    tableView.register(RecordCell.self, forCellReuseIdentifier: RecordCell.identifier)
    tableView.tableHeaderView = self.headerView
    tableView.tableHeaderView?.frame.size.height = height
    tableView.tableFooterView = UIView()
    tableView.tableFooterView?.frame.size.height = 15
    tableView.rowHeight = 130
    tableView.separatorStyle = .none
    tableView.showsVerticalScrollIndicator = false
    tableView.refreshControl = self.refreshControl
  }
}

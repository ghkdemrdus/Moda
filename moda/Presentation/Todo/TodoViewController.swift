//
//  TodoViewController.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import UIKit

class TodoViewController: UIViewController {
  
  var viewModel = TodoViewModel()
  lazy var contentView = TodoView()
  
  override func loadView() {
    self.view = self.contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModel()
    self.viewModel.viewDidLoad()
  }
}

extension TodoViewController {
  private func bindViewModel() {
//    self.contentView.onClickDate = { [weak self] section, item in
//      self?.viewModel.clickDate(section, item)
//    }
    self.viewModel.didUpdateDates = { [weak self] in
      self?.contentView.updateDates($0)
    }
  }
}

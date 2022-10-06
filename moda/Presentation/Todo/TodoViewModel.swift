//
//  TodoViewModel.swift
//  moda
//
//  Created by 황득연 on 2022/10/05.
//

import Foundation

protocol TodoViewModelType {
  
  
  //Input
  func clickDate(_ item: Int)

  //Output
  var didUpdateDates: (([DateItem]) -> Void)? { get set }
  var didUpdateDateClicked: (([DateItem]) -> Void)? { get set }
}

class TodoViewModel: TodoViewModelType {
  var didUpdateDateClicked: (([DateItem]) -> Void)?
  
  
  // MARK: - Outputs
  var didUpdateDates: (([DateItem]) -> Void)?

  // MARK: - Models
  var dates: [DateItem] = []
  var clickedDate: Date?
  
}

// MARK: - Inputs
extension TodoViewModel {
  func viewDidLoad() {
    self.getInitialDates()
  }
  
  func clickDate(_ item: Int) {
    self.dates[item].isSelected = true
//    self.clickedDate = self.dates[item]
//    self.didUpdateDateClicked?(item)
  }
}

// MARK: - Date Manager
extension TodoViewModel {
  func getInitialDates() {
    let dates = DateManager().initialDates()
    self.dates = dates
    self.clickedDate = Date().today()
    self.didUpdateDates?(dates)
  }
}

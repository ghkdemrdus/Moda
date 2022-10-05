//
//  TodoViewModel.swift
//  moda
//
//  Created by 황득연 on 2022/10/05.
//

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
  
  
}

// MARK: - Inputs
extension TodoViewModel {
  func viewDidLoad() {
    self.getInitialDates()
  }
  
  func clickDate(_ item: Int) {
//    self.didUpdateDates?(item, false, false)
  }
}

// MARK: - Date Manager
extension TodoViewModel {
  func getInitialDates() {
    let dates = DateManager().initialDates()
    self.dates = dates
    self.didUpdateDates?(dates)
  }
}

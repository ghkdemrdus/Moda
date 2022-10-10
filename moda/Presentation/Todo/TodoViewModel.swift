//
//  TodoViewModel.swift
//  moda
//
//  Created by 황득연 on 2022/10/05.
//

import Foundation

import RxSwift
import RxRelay

class TodoViewModel {
  var didUpdateDateClicked: (([DateItem]) -> Void)?
  
  struct Input {
    let viewWillAppearEvent: Observable<Void>
  }
  
  struct Output {
    var dateArray = BehaviorRelay<[DateItem?]>(value: [])
  }
  
  // MARK: - Models
  var clickedDate: Date?
  private(set) var initialLoad = true
  
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    
    input.viewWillAppearEvent
      .subscribe(onNext: { [weak self] in
        self?.getInitialDates(output: output)
      })
      .disposed(by: disposeBag)
    
    return output
  }
}

// MARK: - Inputs
extension TodoViewModel {
//  func viewDidLoad() {
//    self.getInitialDates()
//  }
  
  func clickDate(_ item: Int) {
//    self.dates[item].isSelected = true
    print("hihi click date ")
    //    self.clickedDate = self.dates[item]
    //    self.didUpdateDateClicked?(item)
  }
}

// MARK: - Date Manager
extension TodoViewModel {
  func getInitialDates(output: Output) {
    let dates = DateManager().initialDates()
    output.dateArray.accept(dates)
    self.clickedDate = Date().today()
  }
}

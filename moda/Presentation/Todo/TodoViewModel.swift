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
    let didLoadData = PublishRelay<Bool>()
  }
  
  // MARK: - Models
  var dates: [DateItem] = []
  var clickedDate: Date?
  private(set) var initialLoad = true
  
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    
    input.viewWillAppearEvent
      .subscribe(onNext: { [weak self] in
        if self?.initialLoad ?? true {
          self?.getInitialDates()
          self?.initialLoad = false
          output.didLoadData.accept(true)
        }
      })
      .disposed(by: disposeBag)
    
    return output
  }
}

// MARK: - Inputs
extension TodoViewModel {
  func viewDidLoad() {
    self.getInitialDates()
  }
  
  func clickDate(_ item: Int) {
    self.dates[item].isSelected = true
    print("hihi click date ")
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
  }
}

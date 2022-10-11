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
    let dateCellDidTapEvent: Observable<Int>
  }
  
  struct Output {
    var dateArray = BehaviorRelay<[DateItem]>(value: [])
    var selectedIndex = BehaviorRelay<Int>(value: 0)
  }
  
  // MARK: - Models
  var clickedDate: Date?
  
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    
    input.viewWillAppearEvent
      .subscribe(onNext: { [weak self] in
        self?.getInitialDates(output: output)
      })
      .disposed(by: disposeBag)
    
    input.dateCellDidTapEvent
      .bind(to: output.selectedIndex)
      .disposed(by: disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    bindDate(output: output, disposeBag: disposeBag)
  }
  
  private func bindDate(output: Output, disposeBag: DisposeBag) {
    Observable.zip(output.selectedIndex, output.selectedIndex.skip(1))
      .subscribe(onNext: { previous, current in
        var list = output.dateArray.value
        list[previous].isSelected = false
        list[current].isSelected = true
        output.dateArray.accept(list)
      })
//      .bind(to: output.indicesToUpdate)
      .disposed(by: disposeBag)
  }
}

// MARK: - Date Manager
extension TodoViewModel {
  func getInitialDates(output: Output) {
    let dates = DateManager().initialDates()
    output.dateArray.accept(dates)
    output.selectedIndex.accept((Int(Date().today().getDay()) ?? 1) - 1)
  }
}

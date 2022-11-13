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

  private let dm = DateManager()
  var initialSetting: Bool = true
  
  struct Input {
    let viewWillAppearEvent: Observable<Void>
    let dateCellDidTapEvent: Observable<Int>
    let previousButtonDidTapEvent: Observable<Void>
    let nextButtonDidTapEvent: Observable<Void>
    let monthlyButtonDidTapEvent: Observable<Void>
    let dailyButtonDidTapEvent: Observable<Void>
    let inputTextFieldDidEditEvent: Observable<String>
    let registerButtonDidTapEvent: Observable<Void>
  }
  
  struct CellInput {
  }
  
  struct Output {
    var dateArray = BehaviorRelay<[DateItem]>(value: [])
    var selectedIndex = BehaviorRelay<Int>(value: 0)
    var month = BehaviorRelay<String>(value: "1")
    var wordOfMonth = BehaviorRelay<String>(value: "January")
    var todoDatas = BehaviorRelay<[TodoDataSection.Model]>(value: TodoDataSection.initialSectionDatas)
    var selectedType = BehaviorRelay<TodoDataSection.TodoSection>(value: .monthly)
    var completeRegister = PublishRelay<Bool>()
  }
  
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    let monthlyTodos = BehaviorRelay<[Todo]>(value: [])
    let dailyTodos = BehaviorRelay<[Todo]>(value: [])
    
    var type: TodoDataSection.TodoSection = .monthly
    var inputText = ""

    
    monthlyTodos.withLatestFrom(output.todoDatas) { todos, todoDatas in
      todoDatas.map {
        guard $0.model != .monthly else {
          if todos.count == 0 {
            let items = [TodoDataSection.TodoItem.monthlyEmpty]
            let sectionModel = TodoDataSection.Model(model: .monthly, items: items)
            return sectionModel
          } else {
            let items = todos.map {TodoDataSection.TodoItem.monthly($0) }
            let sectionModel = TodoDataSection.Model(model: .monthly, items: items)
            return sectionModel
          }
        }
        return $0
      }
    }
    .bind(to: output.todoDatas)
    .disposed(by: disposeBag)
    
//    monthlyTodos.accept([Todo(content: "ㅁㄷㅇㄹㅁ여ㅛ셔ㅛㅁㅈ요ㅕㅁㅈㅅ요ㅕㅁㅈㅅ요ㅕㅈㅁ쇼엿ㅈ묘ㅕㅇ쇼ㅕㅁㅈㅇ셧ㅁ져ㅛㅈㅁ", isDone: false),Todo(content: "1", isDone: false),Todo(content: "1", isDone: false),Todo(content: "1", isDone: false)])
    
    dailyTodos.withLatestFrom(output.todoDatas) { todos, todoDatas in
      todoDatas.map {
        guard $0.model != .daily else {
          if todos.count == 0 {
            let items = [TodoDataSection.TodoItem.dailyEmpty]
            let sectionModel = TodoDataSection.Model(model: .daily, items: items)
            return sectionModel
          } else {
            let items = todos.map {TodoDataSection.TodoItem.daily($0) }
            let sectionModel = TodoDataSection.Model(model: .daily, items: items)
            return sectionModel
          }
        }
        return $0
      }
    }
    .bind(to: output.todoDatas)
    .disposed(by: disposeBag)
    
//    dailyTodos.accept([Todo(content: "ㄴㄷ론다론ㄹ다여ㅛ셔ㅛㅁㅈ요ㅕㅁㅈㅅ요ㅕㅁㅈㅅ요ㅕㅈㅁ쇼엿ㅈ묘ㅕㅇ쇼ㅕㅁㅈㅇ셧ㅁ져ㅛㅈㅁ", isDone: false),Todo(content: "11231231232", isDone: false),Todo(content: "1", isDone: false),Todo(content: "1", isDone: false)])
 

    self.bindOutput(output: output, disposeBag: disposeBag)
    
    input.viewWillAppearEvent
      .subscribe(onNext: { [weak self] in
        self?.getInitialDates(output: output)
      })
      .disposed(by: disposeBag)
    
    input.dateCellDidTapEvent
      .bind(to: output.selectedIndex)
      .disposed(by: disposeBag)
    
    input.previousButtonDidTapEvent
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let newDates = self.dm.getPreviousDates(from: output.dateArray.value[0].date)
        self.updateUI(output: output, dates: newDates, selectedDay: 0)
      })
      .disposed(by: disposeBag)
    
    input.nextButtonDidTapEvent
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let newDates = self.dm.getFollowingDates(from: output.dateArray.value[0].date)
        self.updateUI(output: output, dates: newDates, selectedDay: 0)
      })
      .disposed(by: disposeBag)
    
    input.monthlyButtonDidTapEvent
      .subscribe(onNext: {
        output.selectedType.accept(.monthly)
        type = .monthly
      })
      .disposed(by: disposeBag)
    
    input.dailyButtonDidTapEvent
      .subscribe(onNext: {
        output.selectedType.accept(.daily)
        type = .daily
      })
      .disposed(by: disposeBag)
    
    input.inputTextFieldDidEditEvent
      .distinctUntilChanged()
      .subscribe(onNext: { input in
        inputText = input
      })
      .disposed(by: disposeBag)
    
    input.registerButtonDidTapEvent
      .subscribe(onNext: {
        guard inputText.count != 0 else { return }
        switch type {
        case .monthly:
          monthlyTodos.accept(monthlyTodos.value + [Todo(id: self.dm.getCurrent(), content: inputText, isDone: false)])
        case .daily:
          dailyTodos.accept(dailyTodos.value + [Todo(id: self.dm.getCurrent(), content: inputText, isDone: false)])
        }
        inputText = ""
        output.completeRegister.accept(true)
      })
      .disposed(by: disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    bindDate(output: output, disposeBag: disposeBag)
    bindMonthly(output: output, disposeBag: disposeBag)
  }
  
  private func bindDate(output: Output, disposeBag: DisposeBag) {
    Observable.zip(output.selectedIndex, output.selectedIndex.skip(1))
      .subscribe(onNext: { previous, current in
        var list = output.dateArray.value
        if list.count > previous {
          list[previous].isSelected = false          
        }
        list[current].isSelected = true
        output.dateArray.accept(list)
      })
      .disposed(by: disposeBag)
  }
  
  private func bindMonthly(output: Output, disposeBag: DisposeBag) {
    
    
    
    
  }
  
  
  
  private func updateUI(output: Output, dates: [DateItem], selectedDay: Int) {
    output.dateArray.accept(dates)
    output.selectedIndex.accept(selectedDay)
    output.month.accept(dates[0].date.getMonth())
    output.wordOfMonth.accept(dm.wordOfMonth[Int(dates[0].date.getMonth())! - 1])
  }
}

// MARK: - Date
extension TodoViewModel {
  func getInitialDates(output: Output) {
    let dates = dm.getDates()
    self.updateUI(output: output, dates: dates, selectedDay: getTodayDateIndex())
  }
  
   func getTodayDateIndex() -> Int {
    return (Int(Date().today().getDay()) ?? 1) - 1
  }
}

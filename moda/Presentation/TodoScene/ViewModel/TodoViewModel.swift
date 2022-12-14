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
  
  struct Input {
    let viewWillAppearEvent: Observable<Void>
    let dateCellDidTapEvent: Observable<Int>
    let previousButtonDidTapEvent: Observable<Void>
    let nextButtonDidTapEvent: Observable<Void>
    let monthlyButtonDidTapEvent: Observable<Void>
    let dailyButtonDidTapEvent: Observable<Void>
    let inputTextFieldDidEditEvent: Observable<String>
    let keyboardDoneKeyDidTapEvent: Observable<Void>
    let registerButtonDidTapEvent: Observable<Void>
  }
  
  struct CellInput {
    let monthlyTodoCheckButtonDidTapEvent: PublishRelay<Todo>
    let dailyTodoCheckButtonDidTapEvent: PublishRelay<Todo>
    let monthyOptionDidTapEvent: PublishRelay<Todo>
    let dailyOptionDidTapEvent: PublishRelay<Todo>
    let arrowButtonDidTapEvent: PublishRelay<Bool>
  }
  
  struct Output {
    var dateArray = BehaviorRelay<[DateItem]>(value: [])
    var selectedIndex = BehaviorRelay<Int>(value: 0)
    var month = BehaviorRelay<String>(value: "1")
    var wordOfMonth = BehaviorRelay<String>(value: "January")
    var todoDatas = BehaviorRelay<[TodoDataSection.Model]>(value: TodoDataSection.initialSectionDatas)
    var selectedType = BehaviorRelay<TodoDataSection.TodoSection>(value: .monthly)
    var showOptionBottomSheet = PublishRelay<Bool>()
    var inputState = BehaviorRelay<InputState>(value: .empty)
    var completeRegister = PublishRelay<Bool>()
  }
  
  private let dm = DateManager()
  private let todoStroage = TodoStorage()
  var initialSetting: Bool = true
  
  var isMonthlyTodosHidden = BehaviorRelay<Bool>(value: true)
  let monthlyTodos = BehaviorRelay<[Todo]>(value: [])
  private var currentDate = BehaviorRelay<Date>(value: Date().plain())
  private let dailyTodos = BehaviorRelay<[Todo]>(value: [])
  private let todoDeleteEvent = PublishRelay<Bool>()
  
  
  func transform(from input: Input, from cellInput: CellInput, disposeBag: DisposeBag) -> Output {
    
    var type: TodoDataSection.TodoSection = .monthly
    var inputText = ""
    var todoInfoTappedOption: (Todo, TodoDataSection.TodoSection)?
    
    let output = Output()
    
    self.todoDeleteEvent
      .subscribe(onNext: { [weak self] _ in
        guard let self = self, let info = todoInfoTappedOption else { return }
        switch info.1 {
        case .monthly:
          let todos = self.monthlyTodos.value.filter { info.0.id != $0.id}
          self.monthlyTodos.accept(todos)
        case .daily:
          let todos = self.dailyTodos.value.filter { info.0.id != $0.id}
          self.dailyTodos.accept(todos)
        }
        self.deleteTodo(todo: info.0)
      })
      .disposed(by: disposeBag)

    self.bindOutput(output: output, disposeBag: disposeBag)
    
    input.viewWillAppearEvent
      .subscribe(onNext: { [weak self] in
        self?.getInitialDates(output: output)
      })
      .disposed(by: disposeBag)
    
    input.dateCellDidTapEvent
      .subscribe(onNext: { [weak self] idx in
        let updatedDate = output.dateArray.value[idx].date
        self?.currentDate.accept(updatedDate)
        output.selectedIndex.accept(idx)
      })
      .disposed(by: disposeBag)
    
    input.previousButtonDidTapEvent
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let newDates = self.dm.getPreviousDates(from: output.dateArray.value[0].date)
        self.currentDate.accept(newDates[0].date)
        self.updateUI(output: output, dates: newDates, selectedDay: 0)
      })
      .disposed(by: disposeBag)
    
    input.nextButtonDidTapEvent
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let newDates = self.dm.getFollowingDates(from: output.dateArray.value[0].date)
        self.currentDate.accept(newDates[0].date)
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
      .subscribe(onNext: { [weak self] input in
        inputText = input
        self?.updateInputState(output: output, inputText: input)
      })
      .disposed(by: disposeBag)
    
    
    Observable.merge(input.keyboardDoneKeyDidTapEvent, input.registerButtonDidTapEvent)
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        guard inputText.count != 0 else { return }
        let todo = Todo(id: self.dm.getUniqueId(), content: inputText, isDone: false)
        switch type {
        case .monthly:
          self.monthlyTodos.accept(self.monthlyTodos.value + [todo])
          self.addMonthlyTodo(date: self.currentDate.value, todo: todo)
        case .daily:
          self.dailyTodos.accept(self.dailyTodos.value + [todo])
          self.addDailyTodo(date: self.currentDate.value, todo: todo)
        }
        inputText = ""
        output.completeRegister.accept(true)
      })
      .disposed(by: disposeBag)
    
    cellInput.monthlyTodoCheckButtonDidTapEvent
      .withLatestFrom(self.monthlyTodos) { [weak self] todo, todos in
        todos.map {
          guard $0.id != todo.id else {
            let updatedTodo = Todo(id: todo.id, content: todo.content, isDone: !todo.isDone)
            self?.updateTodo(todo: updatedTodo)
            return updatedTodo
          }
          return $0
        }
      }
      .bind(to: self.monthlyTodos)
      .disposed(by: disposeBag)
    
    cellInput.dailyTodoCheckButtonDidTapEvent
      .withLatestFrom(self.dailyTodos) { [weak self] todo, todos in
        todos.map {
          guard $0.id != todo.id else {
            let updatedTodo = Todo(id: todo.id, content: todo.content, isDone: !todo.isDone)
            self?.updateTodo(todo: updatedTodo)
            return updatedTodo
          }
          return $0
        }
      }
      .bind(to: self.dailyTodos)
      .disposed(by: disposeBag)
    
    cellInput.monthyOptionDidTapEvent
      .subscribe(onNext: { todo in
        output.showOptionBottomSheet.accept(true)
        todoInfoTappedOption = (todo, .monthly)
      })
      .disposed(by: disposeBag)
    
    cellInput.dailyOptionDidTapEvent
      .subscribe(onNext: { todo in
        output.showOptionBottomSheet.accept(true)
        todoInfoTappedOption = (todo, .daily)
      })
      .disposed(by: disposeBag)
    
    cellInput.arrowButtonDidTapEvent
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.isMonthlyTodosHidden.accept(!self.isMonthlyTodosHidden.value)
      })
      .disposed(by: disposeBag)
 
    
    Observable.zip(self.currentDate, self.currentDate.skip(1))
      .subscribe(onNext: { [weak self] previous, current in
        self?.fetchMonthlyTodos(date: current, disposeBag: disposeBag)
        self?.fetchDailyTodos(date: current, disposeBag: disposeBag)
      })
      .disposed(by: disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    bindDate(output: output, disposeBag: disposeBag)
    bindTodos(output: output, disposeBag: disposeBag)
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
  
  private func bindTodos(output: Output, disposeBag: DisposeBag) {
    Observable.combineLatest(monthlyTodos, isMonthlyTodosHidden).withLatestFrom(output.todoDatas) { data, todoDatas in
      let todos = data.0
      let isHidden = data.1
      return todoDatas.map {
        guard $0.model != .monthly else {
          if todos.count == 0 {
            let items = [TodoDataSection.TodoItem.monthlyEmpty]
            let sectionModel = TodoDataSection.Model(model: .monthly, items: items)
            return sectionModel
          } else {
            if isHidden {
              let items =  Array(todos.map {TodoDataSection.TodoItem.monthly($0) }.prefix(3))
              let sectionModel = TodoDataSection.Model(model: .monthly, items: items)
              return sectionModel
            } else {
              let items = todos.map {TodoDataSection.TodoItem.monthly($0) }
              let sectionModel = TodoDataSection.Model(model: .monthly, items: items)
              return sectionModel
            }
          }
        }
        return $0
      }
    }
    .bind(to: output.todoDatas)
    .disposed(by: disposeBag)

    
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
  }
  
  
  
  private func updateUI(output: Output, dates: [DateItem], selectedDay: Int) {
    output.dateArray.accept(dates)
    output.selectedIndex.accept(selectedDay)
    output.month.accept(dates[0].date.toMonthFormat())
    output.wordOfMonth.accept(dm.wordOfMonth[Int(dates[0].date.toMonthFormat())! - 1])
  }
  
  private func updateInputState(output: Output, inputText: String) {
    if inputText.count == 0 {
      output.inputState.accept(.empty)
    } else {
      output.inputState.accept(.edit)
    }
  }
}

// MARK: - Date
extension TodoViewModel {
  func getInitialDates(output: Output) {
    let dates = dm.getDates()
    self.currentDate.accept(Date().plain())
    self.updateUI(output: output, dates: dates, selectedDay: getTodayDateIndex())
  }
  
  func getTodayDateIndex() -> Int {
    return (Int(Date().plain().toDayFormat()) ?? 1) - 1
  }
}

// MARK: - Realm
extension TodoViewModel {
  func fetchMonthlyTodos(date: Date, disposeBag: DisposeBag) {
    
    self.todoStroage.fetchMonthlyTodos(date: date)
      .subscribe(onNext: { [weak self] todos in
        guard let todos = todos else {
          self?.monthlyTodos.accept([])
          return
        }
        self?.monthlyTodos.accept(todos)
      })
      .disposed(by: disposeBag)
  }
  
  func fetchDailyTodos(date: Date, disposeBag: DisposeBag) {
    self.todoStroage.fetchDailyTodos(date: date)
      .subscribe(onNext: { [weak self] todos in
        guard let todos = todos else {
          self?.dailyTodos.accept([])
          return
        }
        self?.dailyTodos.accept(todos)
      })
      .disposed(by: disposeBag)
  }
  
  func addMonthlyTodo(date: Date, todo: Todo) {
    self.todoStroage.addMonthlyTodo(date: date, todo: todo)
  }
  
  func addDailyTodo(date: Date, todo: Todo) {
    self.todoStroage.addDailyTodo(date: date, todo: todo)
  }
  
  func updateTodo(todo: Todo) {
    self.todoStroage.updateTodo(todo: todo)
  }
  
  func deleteTodo(todo: Todo ) {
    self.todoStroage.deleteTodo(todo: todo)
  }
  
}

extension TodoViewModel {
  func deleteTodoByDelegate() {
    self.todoDeleteEvent.accept(true)
  }
}


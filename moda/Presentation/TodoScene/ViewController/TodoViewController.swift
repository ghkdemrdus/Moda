//
//  TodoViewController.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation

import SnapKit
import Then
import RxSwift
import RxCocoa

import RxDataSources

class TodoViewController: UIViewController {
  
  //MARK: - UI
  private let leftArrowButton =  UIButton().then {
    $0.setImage(UIImage(named: "iconArrowLeft"), for: .normal)
    $0.contentMode = .scaleAspectFill
  }
  
  private let rightArrowButton = UIButton().then {
    $0.setImage(UIImage(named: "iconArrowRight"), for: .normal)
    $0.contentMode = .scaleAspectFill
  }
  
  private let monthLabel = UILabel().then {
    $0.textColor = .black
    $0.textAlignment = .center
    $0.font = .spoqaHanSansNeo(type: .bold, size: 28)
    $0.text = "10"
  }
  
  private let wordOfMonthLabel = UILabel().then {
    $0.textColor = .black
    $0.textAlignment = .center
    $0.font = .spoqaHanSansNeo(type: .bold, size: 18)
    $0.text = "October"
  }
  
  private let todoHeaderView = UIView().then {
    $0.backgroundColor = .white
  }
  private let dateView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 8
  }
  
  private let inputDividerView = UIView().then {
    $0.backgroundColor = .inputDividerBg
  }
  
  private let monthlyButton = UIButton().then {
    $0.setTitle("M", for: .normal)
    $0.setTitleColor(.darkBurgundy1, for: .normal)
    $0.layer.cornerRadius = 5
  }
  
  private let dailyButton = UIButton().then {
    $0.setTitle("D", for: .normal)
    $0.setTitleColor(.darkBurgundy1, for: .normal)
    $0.layer.cornerRadius = 5
    
  }
  
  private let inputTextField = BottomInputTextField().then {
    $0.layer.cornerRadius = 17.5
    $0.backgroundColor = .lightGray
    $0.returnKeyType = .done
  }
  
  private let registerButton = UIButton().then {
    $0.setImage(.monthlyDoActive, for: .normal)
  }
  
  private let dateCollectionView = DateView()
  private lazy var todoCollectionView = TodoView(todoDataSource: self.todoDataSource)
  private let bottomInputView = UIView()
  
  var viewModel = TodoViewModel()
  private let disposeBag = DisposeBag()
  //  private var keyboardHeight: CGFloat = 0
  private var todoDataSource: RxCollectionViewSectionedNonAnimatedDataSource<TodoDataSection.Model>!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    let cellInput = self.configureCollectionView()
    self.configureUI()
    
    self.bindViewModel(cellInput: cellInput)
    self.bindKeyboard()
  }
  
  @objc func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if viewModel.initialSetting == true {
      self.initialScroll()
      viewModel.initialSetting = false
    }
  }
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
    self.view.endEditing(true)
  }
}

// MARK: - Configure UI
extension TodoViewController {
  private func setupView() {
    self.view.backgroundColor = .white
    self.dateView.addArrangedSubview(monthLabel)
    self.dateView.addArrangedSubview(wordOfMonthLabel)
    self.dateCollectionView.showsHorizontalScrollIndicator = false
  }
  
  private func configureUI() {
    
    // MARK: - Date Header
    self.view.addSubview(todoHeaderView)
    self.todoHeaderView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(0)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(202)
      $0.height.equalTo(35)
    }
    self.todoHeaderView.addSubview(self.leftArrowButton)
    self.leftArrowButton.snp.makeConstraints {
      $0.top.leading.bottom.equalToSuperview()
    }
    
    self.todoHeaderView.addSubview(self.dateView)
    self.dateView.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
    
    self.todoHeaderView.addSubview(self.rightArrowButton)
    self.rightArrowButton.snp.makeConstraints {
      $0.top.trailing.bottom.equalToSuperview()
    }
    
    // MARK: - Date
    self.view.addSubview(self.dateCollectionView)
    self.dateCollectionView.snp.makeConstraints {
      $0.top.equalTo(self.todoHeaderView.snp.bottom).offset(10)
      $0.right.left.equalToSuperview().inset(30)
      $0.height.equalTo(64)
    }
    
    // MARK: - Bottom Input
    self.view.addSubview(self.bottomInputView)
    self.bottomInputView.snp.makeConstraints {
      $0.left.right.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
      $0.height.equalTo(51)
    }
    
    self.bottomInputView.addSubview(self.inputDividerView)
    self.inputDividerView.snp.makeConstraints {
      $0.top.left.right.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    self.bottomInputView.addSubview(self.monthlyButton)
    self.monthlyButton.snp.makeConstraints {
      $0.top.left.equalToSuperview().offset(14)
      $0.width.height.equalTo(24)
    }
    
    self.bottomInputView.addSubview(self.dailyButton)
    self.dailyButton.snp.makeConstraints {
      $0.centerY.equalTo(self.monthlyButton)
      $0.left.equalTo(self.monthlyButton.snp.right).offset(2)
      $0.width.height.equalTo(24)
    }
    
    self.bottomInputView.addSubview(self.inputTextField)
    self.inputTextField.snp.makeConstraints {
      $0.centerY.equalTo(self.monthlyButton)
      $0.left.equalTo(self.dailyButton.snp.right).offset(7)
      $0.right.equalToSuperview().offset(-15)
      $0.height.equalTo(35)
    }
    
    self.bottomInputView.addSubview(self.registerButton)
    self.registerButton.snp.makeConstraints {
      $0.centerY.equalTo(self.monthlyButton)
      $0.right.equalToSuperview().offset(-20)
    }
    
    // MARK: - Todo
    self.view.addSubview(self.todoCollectionView)
    self.todoCollectionView.snp.makeConstraints {
      $0.top.equalTo(self.dateCollectionView.snp.bottom).offset(18)
      $0.bottom.equalTo(self.bottomInputView.snp.top)
      $0.left.right.equalToSuperview().inset(16)
    }
    
  }
  
  private func configureCollectionView() -> TodoViewModel.CellInput {
    let updateMonthlyTodo = PublishRelay<Todo>()
    let updateDailyTodo = PublishRelay<Todo>()
    let monthlyOptionDidTap = PublishRelay<Todo>()
    let dailyOptionDidTap = PublishRelay<Todo>()
    let arrowDidTap = PublishRelay<Bool>()
    
    self.todoDataSource = RxCollectionViewSectionedNonAnimatedDataSource<TodoDataSection.Model>(
      configureCell: { dataSource, tableView, indexPath, item in
        switch item {
        case .monthly(let todo):
          let cell = self.todoCollectionView.dequeueReusableCell(MonthlyTodoCell.self, for: indexPath)
          cell.updateUI(todo: todo)
          cell.onCheckClick()
            .subscribe(onNext: {
              updateMonthlyTodo.accept(todo)
            })
            .disposed(by: cell.disposeBag)
          cell.onOptionClick()
            .subscribe(onNext: {
              monthlyOptionDidTap.accept(todo)
            })
            .disposed(by: cell.disposeBag)
          return cell
        case .daily(let todo):
          let cell = self.todoCollectionView.dequeueReusableCell(DailyTodoCell.self, for: indexPath)
          cell.updateUI(todo: todo)
          cell.onCheckClick()
            .subscribe(onNext: {
              updateDailyTodo.accept(todo)
            })
            .disposed(by: cell.disposeBag)
          cell.onOptionClick()
            .subscribe(onNext: {
              dailyOptionDidTap.accept(todo)
            })
            .disposed(by: cell.disposeBag)
          return cell
        case .monthlyEmpty:
          let cell = self.todoCollectionView.dequeueReusableCell(MonthlyEmptyCell.self, for: indexPath)
          return cell
        case .dailyEmpty:
          let cell = self.todoCollectionView.dequeueReusableCell(DailyEmptyCell.self, for: indexPath)
          return cell
        }
        
      })
    
    self.todoDataSource.configureSupplementaryView = { (dataSource, collectionView, kind, indexPath) in
      if kind == UICollectionView.elementKindSectionHeader {
        let section = collectionView.dequeueReusableHeaderView(TodoHeaderView.self, for: indexPath)
        let sectionModel = self.todoDataSource.sectionModels[indexPath.section]
        switch sectionModel.model {
        case .monthly:
          section.updateUI(title: "먼쓸리 투두", itemCount: sectionModel.items.count)
          section.onClickArrow()
            .subscribe(onNext: {
              arrowDidTap.accept(true)
              //              self.todoCollectionView.supplementaryView(forElementKind: "TodoHeaderView", at: indexPath)?.setNeedsDisplay()
            })
            .disposed(by: section.disposeBag)
          Observable.combineLatest(self.viewModel.monthlyTodos, self.viewModel.isMonthlyTodosHidden)
            .subscribe(onNext: { todos, isHidden in
              section.updateArrow(itemCount: todos.count, isHidden: isHidden)
            })
            .disposed(by: self.disposeBag)
        case .daily:
          section.updateUI(title: "데일리 투두")
        }
        return section
      } else {
        return UICollectionReusableView()
      }
    }
    
    return TodoViewModel.CellInput(
      monthlyTodoCheckButtonDidTapEvent: updateMonthlyTodo,
      dailyTodoCheckButtonDidTapEvent: updateDailyTodo,
      monthyOptionDidTapEvent: monthlyOptionDidTap,
      dailyOptionDidTapEvent: dailyOptionDidTap,
      arrowButtonDidTapEvent: arrowDidTap
    )
  }
}

// MARK: - Bind ViewModel
extension TodoViewController {
  private func bindViewModel(cellInput: TodoViewModel.CellInput) {
    let input = TodoViewModel.Input(
      viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in },
      dateCellDidTapEvent: self.dateCollectionView.rx.itemSelected.map { $0.row },
      previousButtonDidTapEvent: self.leftArrowButton.rx.tap.asObservable(),
      nextButtonDidTapEvent: self.rightArrowButton.rx.tap.asObservable(),
      monthlyButtonDidTapEvent: self.monthlyButton.rx.tap.asObservable(),
      dailyButtonDidTapEvent: self.dailyButton.rx.tap.asObservable(),
      inputTextFieldDidEditEvent: self.inputTextField.rx.text.orEmpty.asObservable(),
      keyboardDoneKeyDidTapEvent: self.inputTextField.rx.controlEvent([.editingDidEndOnExit]).asObservable(),
      registerButtonDidTapEvent: self.registerButton.rx.tap.asObservable()
    )
    
    let output = self.viewModel.transform(from: input, from: cellInput, disposeBag: self.disposeBag)
    self.bindDateArray(output: output)
    self.bindTodos(output: output)
    self.bindInput(output: output)
  }
  
  func bindDateArray(output: TodoViewModel.Output?) {
    output?.dateArray
      .asDriver()
      .drive(
        self.dateCollectionView.rx.items(
          cellIdentifier: String(describing: DateCell.self),
          cellType: DateCell.self
        )
      ) { _, model, cell in
        cell.configure(with: model)
      }
      .disposed(by: self.disposeBag)
    output?.selectedIndex
      .asDriver()
      .drive(onNext: { index in
        if let count = output?.dateArray.value.count {
          if count > 0 {
            self.dateCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: index != 0 ? true : false)
          }
        }
      })
      .disposed(by: self.disposeBag)
    
    output?.month
      .asDriver()
      .drive(self.monthLabel.rx.text)
      .disposed(by: self.disposeBag)
    
    output?.wordOfMonth
      .asDriver()
      .drive(self.wordOfMonthLabel.rx.text)
      .disposed(by: self.disposeBag)
  }
  
  func bindTodos(output: TodoViewModel.Output?) {
    output?.todoDatas
      .bind(to: self.todoCollectionView.rx.items(dataSource: self.todoDataSource))
      .disposed(by: self.disposeBag)
    
    output?.showOptionBottomSheet
      .subscribe(onNext: { [weak self] _ in
        self?.showOptionBottomSheet()
      })
      .disposed(by: self.disposeBag)
  }
  
  func bindInput(output: TodoViewModel.Output?) {
    output?.selectedType
      .asDriver()
      .drive(onNext: { [weak self] type in
        self?.monthlyButton.do {
          $0.backgroundColor = type == .monthly ? .lightOrange : .white
          $0.titleLabel?.font = .spoqaHanSansNeo(type: type == .monthly ? .bold : .regular, size: 13)
        }
        self?.dailyButton.do {
          $0.backgroundColor = type == .monthly ? .white : .lightOrange
          $0.titleLabel?.font = .spoqaHanSansNeo(type: type == .monthly ? .regular : .bold, size: 13)
        }
      })
      .disposed(by: self.disposeBag)
    
    output?.completeRegister
      .asDriver(onErrorJustReturn: true)
      .drive(onNext: { [weak self] _ in
        self?.inputTextField.text = ""
        self?.view.endEditing(true)
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - Bind Keyboard
extension TodoViewController {
  
  private func bindKeyboard() {
    self.keyboardHeight()
      .subscribe(onNext: { [weak self] keyboardHeight in
        guard let self = self else { return }
        let height = keyboardHeight > 0 ? -keyboardHeight + self.view.safeAreaInsets.bottom : 0
        self.bottomInputView.snp.updateConstraints {
          $0.height.equalTo(51)
          $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(height)
        }
        self.view.layoutIfNeeded()
      })
      .disposed(by: disposeBag)
    
    self.dismissKeyboardbyTouchAnywhere()
  }
  
  private func dismissKeyboardbyTouchAnywhere() {
    //    dateCollectionView.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    tap.delegate = self
    //    tap.
    self.view.addGestureRecognizer(tap)
  }
}

extension TodoViewController {
  private func initialScroll() {
    let day = viewModel.getTodayDateIndex()
    self.dateCollectionView.scrollToItem(at: IndexPath(row: day, section: 0), at: .centeredHorizontally, animated: false)
  }
  
  private func showOptionBottomSheet() {
    let bottomSheetVC = OptionBottomSheetViewController()
    bottomSheetVC.modalPresentationStyle = .overFullScreen
    bottomSheetVC.delegate = self
    self.present(bottomSheetVC, animated: false, completion: nil)
  }
  
  func keyboardHeight() -> Observable<CGFloat> {
    return Observable
      .from([
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
          .map { notification -> CGFloat in
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
          },
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
          .map { _ -> CGFloat in
            0
          }
      ])
      .merge()
  }
}

extension TodoViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    if touch.view?.isDescendant(of: self.dailyButton) == true || touch.view?.isDescendant(of: self.monthlyButton) == true  || touch.view?.isDescendant(of: self.registerButton) == true {
      return false
    }
    return true
  }
}

extension TodoViewController: BottomSheetDismissDelegate {
  func deleteTodo() {
    self.viewModel.deleteTodoByDelegate()
  }
}

//#if canImport(SwiftUI) && DEBUG
//struct TodoViewController_Previews: PreviewProvider {
//  static var previews: some View {
//    TodoViewController().showPreview(.iPhone13Pro)
//  }
//}
//#endif

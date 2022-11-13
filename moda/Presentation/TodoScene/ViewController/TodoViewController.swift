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
    $0.backgroundColor = .systemBackground
  }
  private let dateView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 8
  }
  
  private let dateCollectionView = DateView()
  private lazy var todoCollectionView = TodoView(todoDataSource: self.todoDataSource)
  private let bottomInputView = UIView()
  private let inputDividerView = UIView().then {
    $0.backgroundColor = .inputDividerBg
  }
  
  private let monthButton = UIButton().then {
    $0.setTitle("M", for: .normal)
    $0.setTitleColor(.burgundy, for: .normal)
    $0.titleLabel?.font = .spoqaHanSansNeo(type: .regular, size: 13)
    $0.layer.cornerRadius = 5
    $0.backgroundColor = .lightOrange
  }
  private let dailyButton = UIButton().then {
    $0.setTitle("D", for: .normal)
    $0.setTitleColor(.burgundy, for: .normal)
    $0.titleLabel?.font = .spoqaHanSansNeo(type: .regular, size: 13)
  }
  
  private let inputTextField = BottomInputTextField().then {
    $0.layer.cornerRadius = 17.5
    $0.backgroundColor = .lightGray
  }
  
  
  var viewModel = TodoViewModel()
  private let disposeBag = DisposeBag()
  private var todoDataSource: RxCollectionViewSectionedNonAnimatedDataSource<TodoDataSection.Model>!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    let cellInput = self.configureCollectionView()
    self.configureUI()
    
    self.bindViewModel()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if viewModel.initialSetting == true {
      self.initialScroll()
      viewModel.initialSetting = false
    }
    
  }
}

// MARK: - Configure UI
extension TodoViewController {
  private func setupView() {
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
      $0.bottom.left.right.equalToSuperview()
      $0.height.equalTo(77.5)
    }
    
    self.bottomInputView.addSubview(self.inputDividerView)
    self.inputDividerView.snp.makeConstraints {
      $0.top.left.right.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    self.bottomInputView.addSubview(self.monthButton)
    self.monthButton.snp.makeConstraints {
      $0.top.left.equalToSuperview().offset(14)
      $0.width.height.equalTo(24)
    }
    
    self.bottomInputView.addSubview(self.dailyButton)
    self.dailyButton.snp.makeConstraints {
      $0.centerY.equalTo(self.monthButton)
      $0.left.equalTo(self.monthButton.snp.right).offset(2)
      $0.width.height.equalTo(24)
    }
    
    self.bottomInputView.addSubview(self.inputTextField)
    self.inputTextField.snp.makeConstraints {
      $0.centerY.equalTo(self.monthButton)
      $0.left.equalTo(self.dailyButton.snp.right).offset(7)
      $0.right.equalToSuperview().offset(-15)
      $0.height.equalTo(35)
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
    let monthlyTodos = PublishRelay<Todo>()
    let dailyTodos = PublishRelay<Todo>()
    
    self.todoDataSource = RxCollectionViewSectionedNonAnimatedDataSource<TodoDataSection.Model>(
      configureCell: { dataSource, tableView, indexPath, item in
        switch item {
        case .monthly(let todo):
          let cell = self.todoCollectionView.dequeueReusableCell(MonthlyTodoCell.self, for: indexPath)
          cell.updateUI(todo: todo)
          return cell
        case .daily(let todo):
          let cell = self.todoCollectionView.dequeueReusableCell(DailyTodoCell.self, for: indexPath)
          cell.updateUI(todo: todo)
          return cell
        case .monthlyEmpty:
          let cell = self.todoCollectionView.dequeueReusableCell(MonthlyEmptyCell.self, for: indexPath)
          return cell
        case .dailyEmpty:
          let cell = self.todoCollectionView.dequeueReusableCell(MonthlyEmptyCell.self, for: indexPath)
          return cell
        }
        
      })
    
    self.todoDataSource.configureSupplementaryView = { (dataSource, collectionView, kind, indexPath) in
      if kind == UICollectionView.elementKindSectionHeader {
        let section = collectionView.dequeueReusableHeaderView(TodoHeaderView.self, for: indexPath)
        switch self.todoDataSource.sectionModels[indexPath.section].model {
        case .monthly:
          section.updateUI(title: "먼쓸리 투두")
        case .daily:
          section.updateUI(title: "데일리 투두")
        }
        return section
      } else {
        return UICollectionReusableView()
      }
    }
    
    return TodoViewModel.CellInput(
      
    )
  }
}

extension TodoViewController {
  private func bindViewModel() {
    let input = TodoViewModel.Input(
      viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in },
      dateCellDidTapEvent: self.dateCollectionView.rx.itemSelected.map { $0.row },
      previousButtonDidTapEvent: self.leftArrowButton.rx.tap.asObservable(),
      nextButtonDidTapEvent: self.rightArrowButton.rx.tap.asObservable()
    )
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    self.bindDateArray(output: output)
    self.bindMonthly(output: output)
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
  
  func bindMonthly(output: TodoViewModel.Output?) {
    output?.todoDatas
      .bind(to: self.todoCollectionView.rx.items(dataSource: self.todoDataSource))
      .disposed(by: self.disposeBag)
  }
}

extension TodoViewController {
  private func initialScroll() {
    let day = viewModel.getTodayDateIndex()
    self.dateCollectionView.scrollToItem(at: IndexPath(row: day, section: 0), at: .centeredHorizontally, animated: false)
  }
}

//#if canImport(SwiftUI) && DEBUG
//struct TodoViewController_Previews: PreviewProvider {
//  static var previews: some View {
//    TodoViewController().showPreview(.iPhone13Pro)
//  }
//}
//#endif

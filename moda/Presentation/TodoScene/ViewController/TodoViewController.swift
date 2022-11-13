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
  
  var viewModel = TodoViewModel()
  private let disposeBag = DisposeBag()
  
  var dataSource: RxCollectionViewSectionedNonAnimatedDataSource<TodoDataSection.Model>!
  
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
  
  private lazy var todoCollectionViewLayout = UICollectionViewCompositionalLayout (sectionProvider: { section, env -> NSCollectionLayoutSection? in
    let section = self.dataSource.sectionModels[section].model
    switch section {
    case .monthly:
      return self.getMonthlyTodoSection()
    case .daily:
      return self.getDailyTodoSection()
    }
  }, configuration: UICollectionViewCompositionalLayoutConfiguration().then {
    $0.interSectionSpacing = 28
  })
    .then {
      $0.register(MonthlySEctionBackgroundDecorationView.self, forDecorationViewOfKind: String(describing: "monthly-section-background"))
    }
  
  private lazy var todoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.todoCollectionViewLayout).then {
    $0.isScrollEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.contentInset = .zero
    $0.backgroundColor = .clear
    $0.clipsToBounds = true
        $0.register(TodoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    $0.register(MonthlyTodoCell.self)
    //    $0.register(DailyTodoCell.self)
  }
  
  
  private let monthlyHeaderView = UIView()
  private let monthlyTitleLabel = UILabel().then {
    $0.text = "먼쓸리 투두"
  }
  
  private lazy var tableView = UITableView().then {
    
    $0.register(TodoCell.self, forCellReuseIdentifier: String(describing: TodoCell.self))
    //    $0.register(MonthlyTodoHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: MonthlyTodoHeaderView.self))
    $0.delegate = self
    $0.dataSource = self
    //    $0.tableHeaderView?.frame.size.height = height
    //    $0.tableFooterView = UIView()
    //    $0.tableFooterView?.frame.size.height = 15
    //    $0.rowHeight = 130
    $0.separatorStyle = .none
    $0.showsVerticalScrollIndicator = false
    $0.backgroundColor = .monthlyBg
    //    $0.refreshControl = self.refreshControl
  }
  
  
  var dateCollectionView = TodoDateView()
  //  var todoCollectionView = TodoView()
  
  private func configureCollectionView() -> TodoViewModel.CellInput {
    let monthlyTodos = PublishRelay<Todo>()
    let dailyTodos = PublishRelay<Todo>()
    
    self.dataSource = RxCollectionViewSectionedNonAnimatedDataSource<TodoDataSection.Model>(
      configureCell: { dataSource, tableView, indexPath, item in
        switch item {
        case .monthly(let todo):
          let cell = self.todoCollectionView.dequeueReusableCell(MonthlyTodoCell.self, for: indexPath)
          cell.updateUI(todo: todo)
          return cell
        case .daily(let todo):
          let cell = self.todoCollectionView.dequeueReusableCell(MonthlyTodoCell.self, for: indexPath)
          return cell
        }
       
      })
    
    self.dataSource.configureSupplementaryView = { (dataSource, collectionView, kind, indexPath) in
      if kind == UICollectionView.elementKindSectionHeader {
        let section = collectionView.dequeueReusableHeaderView(TodoHeaderView.self, for: indexPath)
        //        switch self.dataSource.sectionModels[indexPath.section].model {
        //        case .monthly:
        //          section.updateUI(title: "000 님을 위한\n향수 추천", content: "어퓸을 사용할수록\n더 잘 맞는 향수를 보여드려요")
        //        case .daily:
        //          section.updateUI(title: "20대 여성이\n많이 찾는 향수", content: "00 님 연령대 분들에게 인기 많은 향수 입니다.")
        //        }
        return section
      } else {
        return UICollectionReusableView()
      }
    }
    
    return TodoViewModel.CellInput(
      
    )
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    self.configureUI()
    let cellInput = self.configureCollectionView()
    
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

extension TodoViewController {
  private func setupView() {
    self.dateView.addArrangedSubview(monthLabel)
    self.dateView.addArrangedSubview(wordOfMonthLabel)
    self.dateCollectionView.showsHorizontalScrollIndicator = false
  }
  
  private func configureUI() {
    
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
    
    self.view.addSubview(self.dateCollectionView)
    self.dateCollectionView.snp.makeConstraints {
      $0.top.equalTo(self.todoHeaderView.snp.bottom).offset(10)
      $0.right.left.equalToSuperview().inset(30)
      $0.height.equalTo(64)
    }
    
    self.view.addSubview(self.todoCollectionView)
    self.todoCollectionView.snp.makeConstraints {
      $0.top.equalTo(self.dateCollectionView.snp.bottom).offset(10)
      $0.bottom.equalToSuperview()
      $0.left.right.equalToSuperview().inset(16)
    }
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
      .bind(to: self.todoCollectionView.rx.items(dataSource: dataSource))
      .disposed(by: self.disposeBag)
  }
}

extension TodoViewController {
  private func initialScroll() {
    let day = viewModel.getTodayDateIndex()
    self.dateCollectionView.scrollToItem(at: IndexPath(row: day, section: 0), at: .centeredHorizontally, animated: false)
  }
}

extension TodoViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}

extension TodoViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  //  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
  //      guard let header = tableView.dequeueReusableHeaderFooterView(
  //          withIdentifier: String(describing: MonthlyTodoHeaderView.self)) as? MonthlyTodoHeaderView else { return UITableViewHeaderFooterView() }
  //
  //
  //      return header
  //  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TodoCell.self),for: indexPath) as? TodoCell else { return UITableViewCell() }
    cell.selectionStyle = .none
    cell.configureUI()
    
    return cell
  }
  
  
}


//#if canImport(SwiftUI) && DEBUG
//struct TodoViewController_Previews: PreviewProvider {
//  static var previews: some View {
//    TodoViewController().showPreview(.iPhone13Pro)
//  }
//}
//#endif

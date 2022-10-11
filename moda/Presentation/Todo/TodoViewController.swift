//
//  TodoViewController.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation
import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class TodoViewController: UIViewController {
  
  var viewModel = TodoViewModel()
  private let disposeBag = DisposeBag()
  
  //MARK: - UI
  private let leftArrowView = UIImageView().then {
    $0.image = .init(named: "iconArrowLeft")
  }
  private let rightArrowView = UIImageView().then {
    $0.image = .init(named: "iconArrowRight")
  }
  
  private let monthNumberLabel = UILabel().then {
    $0.textColor = .black
    $0.textAlignment = .center
    $0.font = UIFont.custom(.bold, 28)
    $0.text = "10"
  }
  
  private let monthTextLabel = UILabel().then {
    $0.textColor = .black
    $0.textAlignment = .center
    $0.font = UIFont.custom(.bold, 18)
    $0.text = "October"
  }
  
  private let titleStackView = UIStackView().then {
    $0.axis = .horizontal
  }
  
  
  var dateCollectionView = TodoDateView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    configureUI()
    bindViewModel()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.initialScroll()
  }
}

extension TodoViewController {
  private func setupView() {
    self.titleStackView.do {
      $0.addArrangedSubview(leftArrowView)
      $0.addArrangedSubview(monthNumberLabel)
      $0.addArrangedSubview(monthTextLabel)
      $0.addArrangedSubview(rightArrowView)
      
      $0.setCustomSpacing(38, after: leftArrowView)
      $0.setCustomSpacing(8, after: monthNumberLabel)
      $0.setCustomSpacing(32, after: monthTextLabel)
    }
    
    self.leftArrowView.do {
      $0.contentMode = .scaleAspectFit
    }
    
    self.rightArrowView.do {
      $0.contentMode = .scaleAspectFit
    }
    
    self.dateCollectionView.showsHorizontalScrollIndicator = false
  }
  
  private func configureUI() {
    
    self.view.addSubview(titleStackView)
    self.titleStackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(0)
      $0.centerX.equalToSuperview()
    }
    self.view.addSubview(dateCollectionView)
    dateCollectionView.snp.makeConstraints {
      $0.top.equalTo(self.titleStackView.snp.bottom).offset(10)
      $0.right.left.equalToSuperview().inset(30)
      $0.height.equalTo(64)
    }
    
  }
}

extension TodoViewController {
  private func bindViewModel() {
    
    let input = TodoViewModel.Input(
      viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in },
      dateCellDidTapEvent: self.dateCollectionView.rx.itemSelected.map { $0.row }
    )
    
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    print(output)
    
    self.bindDateArray(output: output)
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
            self.dateCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
          }
        }
      })
      .disposed(by: self.disposeBag)
      
  }
}

extension TodoViewController {
  private func initialScroll() {
    let day = Int(Date().today().getDay()) ?? 1
    self.dateCollectionView.scrollToItem(at: IndexPath(row: day - 1, section: 0), at: .centeredHorizontally, animated: false)

  }
}


//#if canImport(SwiftUI) && DEBUG
//struct TodoViewController_Previews: PreviewProvider {
//  static var previews: some View {
//    TodoViewController().showPreview(.iPhone13Pro)
//  }
//}
//#endif

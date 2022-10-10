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
    //    $0.distribution = .fill // default
    //    $0.alignment = .fill
  }
  
  //  var dateCollectionView : UICollectionView = {
  //    var layout = UICollectionViewFlowLayout()
  //    layout.scrollDirection = .horizontal
  //
  //    layout.minimumInteritemSpacing = 0
  //    //    layout.sectionInset = .zero
  //
  //    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
  //    return cv
  //  }()
  
  var dateCollectionView = TodoDateView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    configureUI()
    bindViewModel()
//    viewModel.viewDidLoad()
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
    
    //    self.dateCollectionView.register(DateCell.self, forCellWithReuseIdentifier: String(describing: DateCell.self))
    //    self.dateCollectionView.showsHorizontalScrollIndicator = false
    //    self.dateCollectionView.dataSource = self
    //    self.dateCollectionView.delegate = self
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
      viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in }
    )
    
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    print(output)
    
    self.bindDateArray(output: output)
    
    //      .asDriver(onErrorJustReturn: false)
    //      .drive(onNext: { [weak self] _ in
    //        self?.view.endEditing(true)
    //        self?.dateCollectionView.reloadData()
    //      })
    //      .disposed(by: self.disposeBag)
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
        print(model)
        cell.configure(with: model)
      }
      .disposed(by: self.disposeBag)
  }

}

extension TodoViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(DateCell.self, for: indexPath)
//    cell.configure(viewModel.dates[indexPath.item])
    //    cell.clickDate = { [weak self] dateIndexPath in
    //      self?.onClickDate?(dateIndexPath.item)
    //    }
    //        print(dates)
    return cell
  }
  
  //  func numberOfSections(in collectionView: UICollectionView) -> Int {
  //    return 1
  //  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 11
  }
}

extension TodoViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
  //    return .init(top: 0, left: 30, bottom: 0, right: 30)
  //  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.size.width
    let height = collectionView.bounds.height
    return .init(width: width / CGFloat(7), height: height)
  }
}

//#if canImport(SwiftUI) && DEBUG
//struct TodoViewController_Previews: PreviewProvider {
//  static var previews: some View {
//    TodoViewController().showPreview(.iPhone13Pro)
//  }
//}
//#endif

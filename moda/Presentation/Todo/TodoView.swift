//
//  TodoView.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import UIKit
import SwiftUI
import PinLayout
import FlexLayout

class TodoView: UIView {
  
  // MARK: - Input
  var onClickDate: ((Int) -> Void)?
  
  
  // MARK: - Data
  private var todoList: [Todo] = []
  private var dates: [DateItem] = []
  
  
  // MARK: - UI
  private let flowLayout = UICollectionViewFlowLayout()
  private let collectionView: UICollectionView
  private let rootFlexContainer = UIView()
  private let monthNumberLabel = UILabel()
  private let monthWordLabel = UILabel()
  private let leftArrow = UIImageView()
  private let rightArrow = UIImageView()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.rootFlexContainer.pin.all(pin.safeArea)
    self.rootFlexContainer.flex.layout()
  }
  
  init() {
    self.collectionView = .init(
      frame: .zero,
      collectionViewLayout: self.flowLayout
    )
    super.init(frame: .zero)
    self.setupView()
    self.defineLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TodoView {
  private func setupView() {
    self.backgroundColor = .white
    self.addSubview(self.rootFlexContainer)
    self.monthNumberLabel.text = "10"
    self.monthNumberLabel.font = UIFont.Custom(.bold, 28)
    self.monthWordLabel.text = "October"
    self.monthWordLabel.font = UIFont.Custom(.bold, 18)
    self.leftArrow.image = .init(named: "iconArrowLeft")
    self.rightArrow.image = .init(named: "iconArrowRight")
    
    self.collectionView.register(DateSectionCell.self, forCellWithReuseIdentifier: String(describing: DateSectionCell.self))
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
  }
  
  private func defineLayout() {
    self.rootFlexContainer.flex
      .define {
        $0.addItem()
          .alignItems(.center)
          .justifyContent(.center)
          .direction(.row)
          .marginTop(7)
          .define {
            $0.addItem(leftArrow)
              .size(24)
            $0.addItem(monthNumberLabel)
              .marginLeft(38)
            $0.addItem(monthWordLabel)
              .marginLeft(8)
            $0.addItem(rightArrow)
              .size(24)
              .marginLeft(32)
          }
        $0.addItem(self.collectionView).grow(1)
          .marginTop(17)
          .marginHorizontal(16)
      }
  }
}


// MARK: - Outputs
extension TodoView {
  func updateDates(_ dates: [DateItem]) {
    self.dates = dates
  }
}

extension TodoView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(DateSectionCell.self, for: indexPath)
    cell.configure(self.dates)
    cell.clickDate = { [weak self] dateIndexPath in
      self?.onClickDate?(dateIndexPath.item)
    }
    //        print(dates)
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
}

extension TodoView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: 30, bottom: 0, right: 30)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = sizeThatFits(
      .init(width: UIScreen.main.bounds.width,
            height: 100)
    ) ?? .zero
    return size
  }
}

#if canImport(SwiftUI) && DEBUG
struct TodoViewController_Previews: PreviewProvider {
  static var previews: some View {
    TodoViewController().showPreview(.iPhone13Pro)
  }
}
#endif

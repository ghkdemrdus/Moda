//
//  TodoView.swift
//  moda
//
//  Created by 황득연 on 2022/10/12.
//

import UIKit

class TodoView: UICollectionView {
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
    self.configureUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.configureUI()
  }
}

private extension TodoView {
  func configureUI() {
    self.collectionViewLayout = self.createCompositionalLayout()
    self.register(MonthlySectionCell.self, forCellWithReuseIdentifier: String(describing: MonthlySectionCell.self))
//    self.register(DailySectionCell.self, forCellWithReuseIdentifier: String(describing: DailySectionCell.self))
    
  }
  
  func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let item = NSCollectionLayoutItem(
      layoutSize: .init(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(1)
      )
    )
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: .init(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalWidth(1)
      ),
      subitems: [item]
    )
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .none
  
    return UICollectionViewCompositionalLayout(section: section)
  }
}

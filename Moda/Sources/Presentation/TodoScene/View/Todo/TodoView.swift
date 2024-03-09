//
//  TodoView.swift
//  moda
//
//  Created by 황득연 on 2022/10/12.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TodoView: UICollectionView {
  
  var todoDataSource: RxCollectionViewSectionedNonAnimatedDataSource<TodoDataSection.Model>
  
  init(todoDataSource: RxCollectionViewSectionedNonAnimatedDataSource<TodoDataSection.Model>) {
    self.todoDataSource = todoDataSource
    super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    self.configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  func configureUI() {
    self.collectionViewLayout = self.todoCollectionViewLayout
    self.isScrollEnabled = true
    self.showsVerticalScrollIndicator = false
    self.contentInset = .zero
    self.backgroundColor = .clear
    self.clipsToBounds = true
    self.register(TodoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    self.register(TodoCell.self)
    self.register(MonthlyEmptyCell.self)
    self.register(DailyEmptyCell.self)
  }
  
  private lazy var todoCollectionViewLayout = UICollectionViewCompositionalLayout (sectionProvider: { section, env -> NSCollectionLayoutSection? in
    let section = self.todoDataSource.sectionModels[section].model
    switch section {
    case .monthly:
      return self.getMonthlyTodoSection()
    case .daily:
      return self.getDailyTodoSection()
    }
  }, configuration: UICollectionViewCompositionalLayoutConfiguration().then {
    $0.interSectionSpacing = 16
  })
    .then {
      $0.register(MonthlySectionBackgroundDecorationView.self, forDecorationViewOfKind: String(describing: "monthly-section-background"))
    }
  
  func getMonthlyTodoSection() -> NSCollectionLayoutSection {

    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(36)
    )

    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(36)
    )

    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .absolute(42)
    )
    
    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 8, trailing: 20)
    section.boundarySupplementaryItems = [header]
    
    let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "monthly-section-background")
    section.decorationItems = [sectionBackground]
    
    return section
  }
  
  func getDailyTodoSection() -> NSCollectionLayoutSection {

    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(44)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(44)
    )
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .absolute(40)
    )

    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 40, trailing: 4)
    section.boundarySupplementaryItems = [header]
    
    return section
  }
}

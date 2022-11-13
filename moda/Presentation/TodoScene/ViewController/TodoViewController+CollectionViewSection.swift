//
//  TodoViewController+CollectionViewSection.swift
//  moda
//
//  Created by 황득연 on 2022/11/11.
//

import Foundation

import UIKit

extension TodoViewController {
  func getMonthlyTodoSection() -> NSCollectionLayoutSection {
    // item
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(36)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //    item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
    
    // group
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(36)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
//    group.contentInsets = NSDirectionalEdgeInsets(top: 23, leading: 16, bottom: 40, trailing: 16)

    
    
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
    // item
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(320)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //    item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
    
    // group
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(320)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    
    
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(90)
    )
    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    
    // section
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 23, leading: 0, bottom: 4, trailing: 0)
    section.boundarySupplementaryItems = [header]
    
    return section
  }
  
}


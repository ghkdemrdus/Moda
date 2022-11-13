//
//  RxCollectionSectionedNonAnimatedDataSource.swift
//  moda
//
//  Created by 황득연 on 2022/11/12.
//

import RxSwift
import RxDataSources

class RxCollectionViewSectionedNonAnimatedDataSource<Section: AnimatableSectionModelType>: RxCollectionViewSectionedAnimatedDataSource<Section> {
  override func collectionView(_ collectionView: UICollectionView, observedEvent: Event<Element>) {
        UIView.performWithoutAnimation {
            super.collectionView(collectionView, observedEvent: observedEvent)
        }
    }
}

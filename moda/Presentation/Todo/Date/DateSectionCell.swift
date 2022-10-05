//
//  DateSection.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import FlexLayout
import PinLayout

class DateSectionCell: UICollectionViewCell {
    private var dates: [DateItem] = []
    
    // MARK: - UI
    private let flowLayout  = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.flex.layout(mode: .adjustHeight)
    }
    
    override init(frame: CGRect) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        super.init(frame: frame)
        self.setupView()
        self.defineLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension DateSectionCell {
    private func setupView() {
        self.flowLayout.scrollDirection = .horizontal
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.register(DateCell.self)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    private func defineLayout() {
        self.contentView.flex
            .direction(.column)
            .define {
                $0.addItem(self.collectionView)
                    .height(3000)

            }
    }
}

extension DateSectionCell {
    func configure(_ dates: [DateItem]) {
        self.collectionView.setContentOffset(.zero, animated: false)
        self.setNeedsLayout()
        self.dates = dates
        self.collectionView.reloadData()
    }
}

extension DateSectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(DateCell.self, for: indexPath)
        let date = self.dates[indexPath.item]
        cell.configure(date)
        return cell
    }
}

extension DateSectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let screenWidth = UIScreen.main.bounds.width
      let widthRatio: CGFloat = 160 / 375
  //    let heightRatio: CGFloat = 174 / 160
      
      let width = (widthRatio * screenWidth).rounded() + 6.0 // 6.0 -> New 뱃지 영역 추가
      let height = collectionView.bounds.height - 32
      return .init(width: (collectionView.frame.size.width - 32) / CGFloat(7), height: height)
    }
}

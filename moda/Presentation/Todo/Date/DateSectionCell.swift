////
////  DateSection.swift
////  moda
////
////  Created by 황득연 on 2022/10/04.
////
//
//import UIKit
//
//class DateSectionCell: UICollectionViewCell {
//
//  private let flowLayout = UICollectionViewFlowLayout()
//  private let collectionView: UICollectionView
//
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    fatalError()
//    setupView()
//  }
//}
//
//extension DateSectionCell {
//
//  private func setupView(){
//
//  }
//}
//
// MARK: - Actions
//  var clickDate: ((IndexPath) -> Void)?
//
//  private var dates: [DateItem] = []
//
//  // MARK: - UI
//  private let flowLayout  = UICollectionViewFlowLayout()
//  private let collectionView: UICollectionView
//
//  override func layoutSubviews() {
//    super.layoutSubviews()
//  }
//
//  override init(frame: CGRect) {
//    self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
//    super.init(frame: frame)
//    self.setupView()
//    self.defineLayout()
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError()
//  }
//
//
//extension DateSectionCell {
//  private func indexPath(date: Date) -> IndexPath? {
//    guard let index = dates.firstIndex(where: {$0.date == date }) else { return nil }
//    return IndexPath(item: index, section: 0)
//  }
//  //    func selectDate(_ date: Date, animated: Bool? = nil) {
//  //        guard let indexPath = indexPath(date: date.plain()) else { return }
//  //        selectItemAt(indexPath)
//  //        scrollToDate(dateItems[indexPath.item].date, animated: animated)
//  //    }
//
//  private func scrollToDate(_ date: Date, animated: Bool? = nil) {
//    guard let indexPath = indexPath(date: date) else { return }
//    print("hihihi: \(indexPath)")
////    collectionView.scrollToItem(at: IndexPath(item: 100, section: 0), at: .centeredHorizontally, animated: animated ?? true)
//  }
//
//  private func setupView() {
//    self.flowLayout.scrollDirection = .horizontal
//    self.collectionView.showsHorizontalScrollIndicator = false
//    self.collectionView.showsVerticalScrollIndicator = false
//    self.collectionView.register(DateCell.self)
//    self.collectionView.dataSource = self
//    self.collectionView.delegate = self
//  }
//
//  private func defineLayout() {
//
//  }
//}
//
//extension DateSectionCell {
//  func configure(_ dates: [DateItem]) {
//    self.collectionView.setContentOffset(.zero, animated: false)
//    self.setNeedsLayout()
//    self.dates = dates
//    self.collectionView.reloadData()
//    self.collectionView.layoutIfNeeded()
//    self.scrollToDate(Date().today(), animated: true)
//  }
//}
////
//extension DateSectionCell: UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return self.dates.count
//  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(DateCell.self, for: indexPath)
//    let date = self.dates[indexPath.item]
//    cell.configure(date)
//    return cell
//  }
//}
//
//extension DateSectionCell: UICollectionViewDelegate {
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    self.clickDate?(indexPath)
//  }
//}
//
//extension DateSectionCell: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//    return .init(top: 0, left: 16, bottom: 0, right: 16)
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//    return 0
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    return 0
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let screenWidth = UIScreen.main.bounds.width
//    let widthRatio: CGFloat = 160 / 375
//    //    let heightRatio: CGFloat = 174 / 160
//
//    let width = (widthRatio * screenWidth).rounded() + 6.0 // 6.0 -> New 뱃지 영역 추가
//    let height = collectionView.bounds.height - 32
//    return .init(width: (collectionView.frame.size.width - 32) / CGFloat(7), height: height)
//  }
//}

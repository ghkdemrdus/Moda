//
//  TodoHeaderView.swift
//  moda
//
//  Created by 황득연 on 2022/11/12.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class TodoHeaderView: UICollectionReusableView {
  
  private let titleLabel = UILabel().then {
    $0.font = .spoqaHanSansNeo(type: .bold, size: 19)
  }

  var disposeBag = DisposeBag()
  var arrowUp = false
  private let arrowButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func prepareForReuse() {
    self.disposeBag = DisposeBag()
    self.arrowButton.setImage(nil, for: .normal)
  }
  
  private func configureUI() {
    self.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(12)
      $0.left.equalToSuperview()
    }
    
    self.addSubview(self.arrowButton)
    self.arrowButton.snp.makeConstraints {
      $0.centerY.equalTo(self.titleLabel)
      $0.right.equalToSuperview()
    }
  }
  
  /// Monthly Header Update
  func updateUI(title: String) {
    self.titleLabel.text = title
    self.titleLabel.textColor = .darkGray1
  }
  
  /// Daily Header Update
  func updateUI(title: String, itemCount: Int) {
    self.titleLabel.text = title
    self.titleLabel.textColor = .darkBurgundy3
    if itemCount <= 3 {
      self.arrowButton.isHidden = true
    }
    self.arrowButton.setImage(.arrowUp, for: .normal)
  }
  
  func updateArrow(itemCount: Int, isHidden: Bool?) {
    guard itemCount > 3 else {
      self.arrowButton.isHidden = true
      return
    }
    self.arrowButton.isHidden = false
    self.arrowButton.setImage(isHidden == true ? .arrowDown : .arrowUp, for: .normal)
  }
  
//  private func bindUI() {
//    self.arrowButton.rx.tap.asObservable()
//      .subscribe(onNext: { [weak self] in
//        self?.arrowUp.toggle()
//        self?.arrowButton.setImage(self?.arrowUp == true ? .arrowUp : .arrowDown, for: .normal)
//      })
//      .disposed(by: self.disposeBag)
//  }
//  
  func onClickArrow() -> Observable<Void> {
    return arrowButton.rx.tap.asObservable()
  }
  
  
}


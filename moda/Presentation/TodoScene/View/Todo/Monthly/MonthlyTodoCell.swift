//
//  MonthlyTodoCell.swift
//  moda
//
//  Created by 황득연 on 2022/11/12.
//

import UIKit
import RxSwift
import SnapKit
import Then

final class MonthlyTodoCell: UICollectionViewCell {
  
  private let checkButton = UIButton()
  
  private let todoLabel = UILabel().then {
    $0.textColor = .todo
    $0.font = .spoqaHanSansNeo(type: .medium, size: 15)
    $0.numberOfLines = 0
  }
  
  private let moreButton = UIButton().then {
    $0.setImage(.monthlyMeatball, for: .normal)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func prepareForReuse() {
    self.checkButton.setImage(nil, for: .normal)
    self.todoLabel.text = nil
  }
  
  private func configureUI() {
    self.contentView.addSubview(self.checkButton)
    self.checkButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(6)
      $0.left.equalToSuperview()
      $0.width.height.equalTo(24)
    }
    
    self.contentView.addSubview(self.moreButton)
    self.moreButton.snp.makeConstraints {
      $0.centerY.equalTo(self.checkButton)
      $0.right.equalToSuperview()
      $0.width.height.equalTo(24)
    }
    
    self.contentView.addSubview(self.todoLabel)
    self.todoLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(8)
      $0.bottom.equalToSuperview().offset(-9)
      $0.left.equalTo(self.checkButton.snp.right).offset(8)
      $0.right.equalTo(self.moreButton.snp.left).offset(-8)
    }
  }
  
  func updateUI(todo: Todo) {
    self.todoLabel.text = todo.content
    self.checkButton.setImage(todo.isDone ? .monthlyDoInactive : .monthlyDoInactive, for: .normal)
  }
}

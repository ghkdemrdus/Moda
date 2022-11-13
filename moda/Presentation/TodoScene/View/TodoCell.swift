//
//  TodoCell.swift
//  moda
//
//  Created by 황득연 on 2022/10/12.
//

import Foundation
import SnapKit
import Then

class TodoCell: UITableViewCell {
  
  private let container = UIView()
  
  private let doneButton = UIButton().then {
    $0.setImage(UIImage(named: "imgHomeMonthlyDoInactive"), for: .normal)
    $0.contentMode = .scaleAspectFill
  }
  
  private let contentLabel = UILabel().then {
    $0.lineBreakMode = .byCharWrapping
    $0.font = .spoqaHanSansNeo(type: .medium, size: 15)
    $0.numberOfLines = 0
    $0.text = "(최대길이)먼쓸리가 두 줄이 가능하다면 어떻게 되는지 설명해주는 화면이랍니다 찡긋 "
  }
  
  private let optionButton = UIButton().then {
    $0.setImage(UIImage(named: "iconHomeMonthlyMeatball"), for: .normal)
    $0.contentMode = .scaleAspectFill
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.configureUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.configureUI()
  }
  
  func updateUI(todo: Todo) {
    self.contentLabel.text = todo.content
    self.doneButton.setImage(UIImage(named: todo.isDone == true ? "imgHomeMonthlyDoActive" : "imgHomeMonthlyDoInactive"), for: .normal)
  }
  
  func configureUI() {
    //    self.selectionStyle = .none
    self.contentView.addSubview(self.container)
    self.container.snp.makeConstraints {
      $0.left.right.equalToSuperview().inset(16)
      $0.top.bottom.equalToSuperview().inset(6)
    }
    
    self.container.addSubview(self.doneButton)
    self.doneButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.left.equalToSuperview()
      $0.width.equalTo(24)
    }
    
    
    //
    self.container.addSubview(self.optionButton)
    self.optionButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.right.equalToSuperview()
      $0.width.equalTo(24)
    }
    self.container.addSubview(self.contentLabel)
    self.contentLabel.snp.makeConstraints {
      $0.top.equalTo(self.doneButton.snp.top).inset(3)
      $0.left.equalTo(self.doneButton.snp.right).offset(8)
      $0.right.equalTo(self.optionButton.snp.left).offset(-8)
    }
  }
}

//
//  MonthlyTodoHeaderView.swift
//  moda
//
//  Created by 황득연 on 2022/10/12.
//

import Foundation
import SnapKit
import Then

class MonthlyTodoHeaderView: UITableViewHeaderFooterView {
  private let headerTitleLabel = UILabel().then {
    $0.text = "먼쓸리 투두"
    $0.font = .spoqaHanSansNeo(type: .bold, size: 19)
        
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: String(describing: MonthlyTodoHeaderView.self))
      self.configureUI()
  }
  
  required init?(coder: NSCoder) {
      super.init(coder: coder)
      self.configureUI()
  }
  
  private func configureUI() {
    addSubview(headerTitleLabel)
    self.headerTitleLabel.snp.makeConstraints {
      $0.left.equalToSuperview().offset(20)
      $0.right.equalToSuperview()
      $0.top.equalToSuperview().inset(12)
    }
  }
}

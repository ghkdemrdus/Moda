//
//  MontlySectionCell.swift
//  moda
//
//  Created by 황득연 on 2022/10/12.
//

import UIKit
import SnapKit
import Then

class MonthlySectionCell: UICollectionViewCell {
  
  private var output: TodoViewModel.Output?
  
  private let titleLabel = UILabel().then {
    $0.text = "먼쓸리 투두"
    $0.font = .spoqaHanSansNeo(type: .bold, size: 19)
  }
  private let todoTableView = UITableView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func configureUI() {
    self.contentView.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints {
      $0.left.top.equalToSuperview()
    }
    
    self.contentView.addSubview(self.todoTableView)
    self.todoTableView.snp.makeConstraints {
      $0.left.right.equalToSuperview()
      $0.top.equalTo(self.titleLabel.snp.bottom).offset(10)
    }
  }
}

//extension MonthlySectionCell: UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return self.output?.monthlyTodos.value.count ?? 0
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TodoCell.self), for: indexPath) as? TodoCell else { return UITableViewCell() }
//    
//    cell.updateUI(todo: output?.monthlyTodos.value[indexPath.item] ?? Todo.default)
//    return cell
//  }
//}

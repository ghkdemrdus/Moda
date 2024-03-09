//
//  TodoCell.swift
//  moda
//
//  Created by 황득연 on 2023/05/05.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class TodoCell: UICollectionViewCell {
  
  private let todoLabel = UILabel().then {
    $0.textColor = .todo
    $0.font = .spoqaHanSansNeo(type: .medium, size: 15)
    $0.numberOfLines = 0
  }
  
  let todoTextField = UITextField().then {
    $0.textColor = .todo
    $0.font = .spoqaHanSansNeo(type: .medium, size: 15)
    $0.returnKeyType = .done
  }
  
  private let dividerView = UIView().then {
    $0.backgroundColor = .dailyDivider
  }
  
  fileprivate var optionButton = UIButton()
  fileprivate var checkButton = UIButton()
  
  var editing = PublishRelay<Bool>()
  var editTodo = PublishRelay<String>()
  var disposeBag = DisposeBag()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
    self.bindUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func prepareForReuse() {
    self.disposeBag = DisposeBag()
    self.bindUI()
    self.checkButton.setImage(nil, for: .normal)
    self.optionButton.setImage(nil, for: .normal)
    self.dividerView.backgroundColor = .clear
    self.todoTextField.isHidden = true
    self.todoLabel.isHidden = false
    self.todoLabel.text = ""
    self.todoTextField.text = ""
  }
  
  private func configureUI() {
    self.todoTextField.isHidden = true
    self.todoLabel.isHidden = false
    self.contentView.addSubview(self.checkButton)
    self.checkButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(6)
      $0.left.equalToSuperview()
      $0.width.height.equalTo(24)
    }
    
    self.contentView.addSubview(self.optionButton)
    self.optionButton.snp.makeConstraints {
      $0.centerY.equalTo(self.checkButton)
      $0.right.equalToSuperview()
      $0.width.height.equalTo(24)
    }
    
    self.contentView.addSubview(self.todoLabel)
    self.todoLabel.snp.makeConstraints {
      $0.top.equalTo(self.checkButton).offset(2)
      $0.bottom.equalToSuperview().offset(-9)
      $0.left.equalTo(self.checkButton.snp.right).offset(8)
      $0.right.equalTo(self.optionButton.snp.left).offset(-8)
    }
    
    self.contentView.addSubview(self.todoTextField)
    self.todoTextField.snp.makeConstraints {
      $0.top.equalTo(self.todoLabel).offset(-1)
      $0.left.equalTo(self.checkButton.snp.right).offset(8)
      $0.right.equalTo(self.optionButton.snp.left).offset(-8)
    }
    
    self.contentView.addSubview(self.dividerView)
    self.dividerView.snp.makeConstraints {
      $0.bottom.left.right.equalToSuperview()
      $0.height.equalTo(0)
    }
  }
  
  func bindUI() {
    Observable.merge(
      self.todoTextField.rx.controlEvent([.editingDidEndOnExit]).asObservable().map { _ in false },
      self.editing.asObservable()
    )
    .asDriver(onErrorDriveWith: .empty())
    .drive(onNext: { [weak self] in
      guard let self = self else { return }
      if $0 {
        self.todoTextField.text = self.todoLabel.text
        self.todoLabel.text = "one line"
        self.todoTextField.becomeFirstResponder()
      } else {
        self.todoLabel.text = self.todoTextField.text
        self.editTodo.accept(self.todoTextField.text ?? "")
      }
      self.todoLabel.isHidden = $0
      self.todoTextField.isHidden = !$0
      self.contentView.invalidateIntrinsicContentSize()
    })
    .disposed(by: self.disposeBag)
  }
  
  func updateUI(todo: Todo) {
    let isMonthly = todo.type == .monthly
    self.todoLabel.text = todo.content
    self.dividerView.backgroundColor = .dailyDivider
    self.optionButton.setImage(isMonthly ? .monthlyMeatball : .dailyMeatball, for: .normal)
    if isMonthly {
      self.checkButton.setImage(todo.isDone ? .monthlyDoActive : .monthlyDoInactive, for: .normal)
      self.checkButton.snp.updateConstraints { 
        $0.top.equalToSuperview().offset(6)
      }
      self.dividerView.snp.updateConstraints {
        $0.height.equalTo(0)
      }
      self.todoLabel.snp.updateConstraints {
        $0.bottom.equalToSuperview().offset(-8)
      }
    } else {
      self.checkButton.setImage(todo.isDone ? .dailyDoActive : .dailyDoInactive, for: .normal)
      self.checkButton.snp.updateConstraints { 
        $0.top.equalToSuperview().offset(10)
      }
      self.dividerView.snp.updateConstraints {
        $0.height.equalTo(1)
      }
      self.todoLabel.snp.updateConstraints {
        $0.bottom.equalToSuperview().offset(-13)
      }
    }
  }
}

extension Reactive where Base == TodoCell {
  var tapCheck: Observable<Void> {
    self.base.checkButton.rx.tap.asObservable()
  }
  
  var tapOption: Observable<Void> {
    self.base.optionButton.rx.tap.asObservable()
  }
}

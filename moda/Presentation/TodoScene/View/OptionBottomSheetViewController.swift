//
//  OptionBottomSheetViewController.swift
//  moda
//
//  Created by 황득연 on 2022/11/17.
//

import UIKit
import RxSwift
import RxGesture
import SnapKit
import Then

class OptionBottomSheetViewController: UIViewController {
  
  weak var delegate: BottomSheetDismissDelegate?
  
  private let dimmedBackView = UIView().then {
    $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
  }
  
  private let bottomSheetView = UIView().then {
    $0.backgroundColor = .bg
    $0.layer.cornerRadius = 14
    $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    $0.clipsToBounds = true
  }
  
  private lazy var buttonStackView = UIStackView().then {
    $0.addArrangedSubview(self.updateButton)
    $0.addArrangedSubview(self.deleteButton)
    $0.axis = .vertical
  }
  
  private let updateButton = UIButton().then {
    $0.setTitle("수정", for: .normal)
    $0.setTitleColor(.todo, for: .normal)
    $0.titleLabel?.font = .spoqaHanSansNeo(type: .medium, size: 17)
    $0.contentHorizontalAlignment = .left
    $0.contentEdgeInsets = UIEdgeInsets(top: 16, left: 25, bottom: 16, right: 0)
  }
  
  private let deleteButton = UIButton().then {
    $0.setTitle("삭제", for: .normal)
    $0.setTitleColor(.todo, for: .normal)
    $0.titleLabel?.font = .spoqaHanSansNeo(type: .medium, size: 17)
    $0.contentHorizontalAlignment = .left
    $0.contentEdgeInsets = UIEdgeInsets(top: 16, left: 25, bottom: 16, right: 0)
  }
  
  private let bottomHeight: CGFloat = 122
  private let disposeBag = DisposeBag()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configureUI()
    self.bindUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.showBottomSheet()
  }
  
  private func configureUI() {
    self.dimmedBackView.alpha = 0.0
    
    self.view.addSubview(self.dimmedBackView)
    self.dimmedBackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    let topConstant = self.view.safeAreaInsets.bottom + self.view.safeAreaLayoutGuide.layoutFrame.height
    self.view.addSubview(self.bottomSheetView)
    self.bottomSheetView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(topConstant)
      $0.bottom.equalToSuperview().priority(.low)
      $0.left.right.equalToSuperview()
    }
    
    self.bottomSheetView.addSubview(self.buttonStackView)
    self.buttonStackView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(14)
      $0.left.right.equalToSuperview()
    }
  }
  
  private func bindUI() {
    self.updateButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.delegate?.updateTodo()
        self?.hideBottomSheet()
      })
      .disposed(by: self.disposeBag)
    
    self.deleteButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.delegate?.deleteTodo()
        self?.hideBottomSheet()
      })
      .disposed(by: self.disposeBag)
    
    self.dimmedBackView.rx.tapGesture().when(.recognized)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.hideBottomSheet()
      })
      .disposed(by: self.disposeBag)
    
    self.bottomSheetView.rx.swipeGesture(.down)
      .skip(1)
      .subscribe(onNext: { [weak self] _ in
        self?.hideBottomSheet()
      })
      .disposed(by: self.disposeBag)
  }
  
  private func showBottomSheet() {
    let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
    
    self.bottomSheetView.snp.updateConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(safeAreaHeight - self.bottomHeight)
    }
    
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.dimmedBackView.alpha = 0.5
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  private func hideBottomSheet() {
    let topConstant = self.view.safeAreaInsets.bottom + self.view.safeAreaLayoutGuide.layoutFrame.height
    self.bottomSheetView.snp.updateConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(topConstant)
    }
    
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.dimmedBackView.alpha = 0.0
      self.view.layoutIfNeeded()
    }) { _ in
      if self.presentingViewController != nil {
        self.dismiss(animated: false, completion: nil)
      }
    }
  }
  
  
  // UISwipeGestureRecognizer 연결 함수 부분
  @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
    if recognizer.state == .ended {
      switch recognizer.direction {
      case .down:
        self.hideBottomSheet()
      default:
        break
      }
    }
  }

}

protocol BottomSheetDismissDelegate: AnyObject {
  func updateTodo()
  func deleteTodo()
}

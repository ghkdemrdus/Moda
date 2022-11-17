//
//  OptionBottomSheetViewController.swift
//  moda
//
//  Created by 황득연 on 2022/11/17.
//

import UIKit
import SnapKit
import Then

class OptionBottomSheetViewController: UIViewController {
  
  let bottomHeight: CGFloat = 359
  
  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
  
  private let dimmedBackView = UIView().then {
    $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
  }

  private let bottomSheetView = UIView().then() {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 27
    $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    $0.clipsToBounds = true
  }
  
  private let dismissIndicatorView = UIView().then {
    $0.backgroundColor = .systemGray2
    $0.layer.cornerRadius = 3
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupGestureRecognizer()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    showBottomSheet()
  }
  
  // MARK: - @Functions
  // UI 세팅 작업
  private func setupUI() {
    self.view.addSubview(self.dimmedBackView)
    self.dimmedBackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.view.addSubview(self.bottomSheetView)
    self.bottomSheetView.snp.makeConstraints {
      $0.bottom.left.right.equalToSuperview()
      $0.height.equalTo(self.bottomHeight)
    }
    
    self.view.addSubview(self.dismissIndicatorView)
    self.dismissIndicatorView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.bottomSheetView).offset(12)
      $0.width.equalTo(102)
      $0.height.equalTo(7)
    }
        
    dimmedBackView.alpha = 0.0
  }
  
  // GestureRecognizer 세팅 작업
  private func setupGestureRecognizer() {
    // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
    let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
    dimmedBackView.addGestureRecognizer(dimmedTap)
    dimmedBackView.isUserInteractionEnabled = true
    
    // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
    swipeGesture.direction = .down
    view.addGestureRecognizer(swipeGesture)
  }
  
  // 레이아웃 세팅
  private func setupLayout() {
    dimmedBackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dimmedBackView.topAnchor.constraint(equalTo: view.topAnchor),
      dimmedBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      dimmedBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      dimmedBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
    let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
    bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
    NSLayoutConstraint.activate([
      bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      bottomSheetViewTopConstraint
    ])
    
    dismissIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dismissIndicatorView.widthAnchor.constraint(equalToConstant: 102),
      dismissIndicatorView.heightAnchor.constraint(equalToConstant: 7),
      dismissIndicatorView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 12),
      dismissIndicatorView.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor)
    ])
    
  }
  
  // 바텀 시트 표출 애니메이션
  private func showBottomSheet() {
    let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding: CGFloat = view.safeAreaInsets.bottom
    
//    bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
    
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.dimmedBackView.alpha = 0.5
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  // 바텀 시트 사라지는 애니메이션
  private func hideBottomSheetAndGoBack() {
    let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding = view.safeAreaInsets.bottom
//    bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.dimmedBackView.alpha = 0.0
      self.view.layoutIfNeeded()
    }) { _ in
      if self.presentingViewController != nil {
        self.dismiss(animated: false, completion: nil)
      }
    }
  }
  
  // UITapGestureRecognizer 연결 함수 부분
  @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
    hideBottomSheetAndGoBack()
  }
  
  // UISwipeGestureRecognizer 연결 함수 부분
  @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
    if recognizer.state == .ended {
      switch recognizer.direction {
      case .down:
        hideBottomSheetAndGoBack()
      default:
        break
      }
    }
  }
}

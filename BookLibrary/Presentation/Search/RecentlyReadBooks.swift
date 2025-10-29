//
//  RecentlyReadBooks.swift
//  BookLibrary
//
//  Created by 김민희 on 10/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RecentlyReadBooks: UIView {
  private let disposeBag = DisposeBag()
  private let bookImageSize = 100

  private let titleLable: UILabel = {
    let label = UILabel()
    label.text = "최근 읽은 책"
    label.font = .systemFont(ofSize: 20, weight: .bold)
    return label
  }()

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.alwaysBounceHorizontal = true
    scrollView.alwaysBounceVertical = false
    return scrollView
  }()

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 16
    return stackView
  }()

  let bookColors = PublishRelay<[UIColor]>()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConfigures()
    setupViews()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension RecentlyReadBooks {
  private func setupConfigures() {
    backgroundColor = .white
  }

  private func setupViews() {
    [
      titleLable,
      scrollView
    ]
      .forEach {
        addSubview($0)
      }

    scrollView.addSubview(stackView)

    setupConstraints()
  }

  private func setupConstraints() {
    titleLable.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview().inset(20)
      make.leading.trailing.equalToSuperview()
    }

    scrollView.snp.makeConstraints { make in
      make.top.equalTo(titleLable.snp.bottom).offset(12)
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalTo(bookImageSize)
    }

    stackView.snp.makeConstraints { make in
      make.edges.equalTo(scrollView.contentLayoutGuide)
      make.height.equalTo(scrollView.frameLayoutGuide.snp.height)
    }
  }

  private func bind() {
    bookColors
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] colors in
        guard let self = self else { return }
        self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for color in colors {
          let circleView = UIView()
          circleView.backgroundColor = color
          circleView.layer.cornerRadius = CGFloat(self.bookImageSize) / 2
          circleView.clipsToBounds = true

          circleView.snp.makeConstraints { make in
            make.width.height.equalTo(self.bookImageSize)
          }

          self.stackView.addArrangedSubview(circleView)
        }
      })
      .disposed(by: disposeBag)
  }
}


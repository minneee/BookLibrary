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

  private let titleLabel: UILabel = {
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

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConfigures()
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension RecentlyReadBooks {
  private func setupConfigures() {
    backgroundColor = .white
    scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }

  private func setupViews() {
    [
      titleLabel,
      scrollView
    ]
      .forEach {
        addSubview($0)
      }

    scrollView.addSubview(stackView)

    setupConstraints()
  }

  private func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview().inset(20)
    }

    scrollView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(12)
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalTo(bookImageSize)
    }

    stackView.snp.makeConstraints { make in
      make.edges.equalTo(scrollView.contentLayoutGuide)
      make.height.equalTo(scrollView.frameLayoutGuide.snp.height)
    }
  }

  func update(with books: [Book]) {
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    if books.isEmpty {
      let emptyView = UIView()
      let label = UILabel()
      label.text = "최근 읽은 책이 없습니다"
      label.textColor = .systemGray
      label.font = .systemFont(ofSize: 14)
      label.textAlignment = .center

      emptyView.addSubview(label)

      label.snp.makeConstraints { make in
        make.center.equalToSuperview()
        make.leading.trailing.equalToSuperview()
      }

      emptyView.snp.makeConstraints { make in
        make.height.equalTo(bookImageSize)
      }

      stackView.addArrangedSubview(emptyView)
      isHidden = true
      return
    }

    isHidden = false

    for book in books {
      let imageView = UIImageView()
      imageView.layer.cornerRadius = CGFloat(bookImageSize) / 2
      imageView.clipsToBounds = true
      imageView.contentMode = .scaleAspectFill

      if let urlStr = book.thumbnail, let url = URL(string: urlStr) {
        DispatchQueue.global().async {
          if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            DispatchQueue.main.async { imageView.image = image }
          }
        }
      } else {
        imageView.image = UIImage(named: "book_sample")
        imageView.backgroundColor = .systemGray4
      }

      imageView.snp.makeConstraints { make in
        make.width.height.equalTo(bookImageSize)
      }
      stackView.addArrangedSubview(imageView)
    }
  }
}


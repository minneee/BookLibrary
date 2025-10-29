//
//  BookCell.swift
//  BookLibrary
//
//  Created by 김민희 on 10/27/25.
//

import UIKit
import SnapKit

final class BookCell: UICollectionViewCell {
  static let reuseIdentifier: String = "BookCell"

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.lineBreakMode = .byTruncatingTail
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 16, weight: .semibold)
    return label
  }()

  private let authorLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
    label.textColor = .gray
    label.font = .systemFont(ofSize: 14, weight: .regular)
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.setContentHuggingPriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    return label
  }()

  private lazy var textStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .leading
    stack.spacing = 4
    return stack
  }()

  private lazy var mainStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.alignment = .center
    stack.spacing = 12
    return stack
  }()

  override init(frame: CGRect) {
    super .init(frame: frame)
    setupConfigures()
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(book: Book) {
    titleLabel.text = book.title
    authorLabel.text = book.authors.joined(separator: ", ")
    priceLabel.text = "\(book.price)원"
  }
}

extension BookCell {
  private func setupConfigures() {
    backgroundColor = .white
  }
  
  private func setupViews() {
    [
      mainStack
    ]
      .forEach {
        contentView.addSubview($0)
      }

    [
      titleLabel,
      authorLabel
    ]
      .forEach {
        textStack.addArrangedSubview($0)
      }

    [
      textStack,
      priceLabel
    ]
      .forEach {
        mainStack.addArrangedSubview($0)
      }

    setupConstraints()
  }

  private func setupConstraints() {
    mainStack.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(12)
      make.leading.trailing.equalToSuperview().inset(20)
    }
  }
}

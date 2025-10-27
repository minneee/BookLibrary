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
    label.numberOfLines = 0
    return label
  }()

  private let authorLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()

  override init(frame: CGRect) {
    super .init(frame: frame)
    setupConfigures()
    setupViews()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(book: Book) {
    titleLabel.text = book.title
    authorLabel.text = book.authors.joined(separator: ", ")
    priceLabel.text = "\(book.price)"
  }
}

extension BookCell {
  private func setupConfigures() {
    backgroundColor = .white
  }
  
  private func setupViews() {
    [
      titleLabel,
      authorLabel,
      priceLabel
    ]
      .forEach {
      contentView.addSubview($0)
    }

    setupConstraints()
  }

  private func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(12)
      make.leading.trailing.equalToSuperview().inset(20)
    }
    
    authorLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.leading.trailing.equalTo(titleLabel)
    }

    priceLabel.snp.makeConstraints { make in
      make.top.equalTo(authorLabel.snp.bottom).offset(8)
      make.leading.trailing.equalTo(titleLabel)
      make.bottom.equalToSuperview().inset(12)
    }
  }

  private func bind() {

  }
}

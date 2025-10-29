//
//  SavedBookCell.swift
//  BookLibrary
//
//  Created by 김민희 on 10/29/25.
//

import UIKit
import SnapKit

final class SavedBookCell: UITableViewCell {
  static let reuseIdentifier: String = "SavedBookCell"
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

  private let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "book_sample")
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    imageView.setContentHuggingPriority(.required, for: .horizontal)
    imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
    return imageView
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

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupConfigures()
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SavedBookCell {
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
      thumbnailImageView,
      textStack
    ]
      .forEach {
        mainStack.addArrangedSubview($0)
      }

    setupConstraints()
  }

  private func setupConstraints() {
    mainStack.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(12)
      make.leading.trailing.equalToSuperview().inset(30)
    }

    thumbnailImageView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.8)
      make.width.equalTo(thumbnailImageView.snp.height).multipliedBy(0.75)
    }
  }
  
  func configure(book: Book) {
    titleLabel.text = book.title
    authorLabel.text = book.authors.joined(separator: ", ")

    if let urlString = book.thumbnail, let url = URL(string: urlString) {
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self.thumbnailImageView.image = image
          }
        }
      }
    } else {
      thumbnailImageView.image = UIImage(named: "book_sample")
    }
  }
}


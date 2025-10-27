//
//  BookDetailViewController.swift
//  BookLibrary
//
//  Created by 김민희 on 10/27/25.
//

import UIKit
import SnapKit

class BookDetailViewController: UIViewController {
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsVerticalScrollIndicator = false
    return scrollView
  }()

  private let contentView = UIView()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "책제목책제목책제목책제목책제목책제목책제목책제목책제목책제목책제목책제목책제목"
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()

  private let authorLabel: UILabel = {
    let label = UILabel()
    label.text = "작가, 작가, 작가, 작가"
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()

  private let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "book_sample")
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .gray
    return imageView
  }()

  private let priceLabel: UILabel = {
    let label = UILabel()
    label.text = "14,000원"
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()

  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다.인간은 변할 수 있고, 누구나 행복해질 수 있다. 단 그러기 위해서는 '용기'가 필요하다고 말한 철학자가 있다. 바로 '세이노'이다."
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.numberOfLines = 0
    return label
  }()

  private let buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 16
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.backgroundColor = .white
    return stackView
  }()

  private let cancelButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("닫기", for: .normal)
    button.backgroundColor = .lightGray
    button.tintColor = .white
    button.layer.cornerRadius = 8
    button.clipsToBounds = true
    return button
  }()

  private let addToLibraryButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("담기", for: .normal)
    button.backgroundColor = .greenButton
    button.tintColor = .white
    button.layer.cornerRadius = 8
    button.clipsToBounds = true
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupConfigures()
    setupViews()
    bind()
  }
}

extension BookDetailViewController {
  private func setupConfigures() {
    view.backgroundColor = .white
  }

  private func setupViews() {
    [
      scrollView,
      buttonStackView,
    ]
      .forEach {
        view.addSubview($0)
      }
    [
      contentView
    ]
      .forEach {
        scrollView.addSubview($0)
      }

    [
      titleLabel,
      authorLabel,
      thumbnailImageView,
      priceLabel,
      descriptionLabel
    ]
      .forEach {
        contentView.addSubview($0)
      }

    [
      cancelButton,
      addToLibraryButton
    ]
      .forEach {
        buttonStackView.addArrangedSubview($0)
      }

    setupConstraints()
  }

  private func setupConstraints() {
    scrollView.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(buttonStackView.snp.top)
    }

    contentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalToSuperview()
    }

    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(40)
      make.leading.trailing.equalToSuperview().inset(20)
      make.centerX.equalToSuperview()
    }

    authorLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(4)
      make.leading.trailing.equalToSuperview().inset(20)
      make.centerX.equalToSuperview()
    }

    thumbnailImageView.snp.makeConstraints { make in
      make.top.equalTo(authorLabel.snp.bottom).offset(20)
      make.centerX.equalToSuperview()
      make.width.equalTo(180)
      make.height.equalTo(240)
    }

    priceLabel.snp.makeConstraints { make in
      make.top.equalTo(thumbnailImageView.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(20)
      make.centerX.equalToSuperview()
    }

    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(priceLabel.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview().inset(30)
    }

    buttonStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
      make.height.equalTo(56)
    }
    cancelButton.snp.makeConstraints { make in
      make.width.equalTo(addToLibraryButton.snp.width).multipliedBy(1.0/3.0)
    }
  }

  private func bind() {
    cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    addToLibraryButton.addTarget(self, action: #selector(addBook), for: .touchUpInside)
  }

  @objc private func dismissView() {
     dismiss(animated: true)
   }

   @objc private func addBook() {
     print("책 담기!")
   }
}

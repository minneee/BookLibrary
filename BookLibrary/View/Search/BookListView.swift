//
//  BookListView.swift
//  BookLibrary
//
//  Created by 김민희 on 10/27/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum Section: Hashable, Sendable {
  case main
}

final class BookListView: UIView {

  let bookRelay: BehaviorRelay<[Book]> = .init(value: [Book(title: "title", contents: "", authors: ["Aa", "Bb"], thumbnail: "", price: 0), Book(title: "title", contents: "", authors: ["Aa", "Bb"], thumbnail: "", price: 0), Book(title: "title", contents: "", authors: ["Aa", "Bb"], thumbnail: "", price: 0), Book(title: "title", contents: "", authors: ["Aa", "Bb"], thumbnail: "", price: 0), Book(title: "title", contents: "", authors: ["Aa", "Bb"], thumbnail: "", price: 0), Book(title: "title", contents: "", authors: ["Aa", "Bb"], thumbnail: "", price: 0), Book(title: "title", contents: "", authors: ["Aa", "Bb"], thumbnail: "", price: 0), Book(title: "title", contents: "", authors: ["Aa", "Bb"], thumbnail: "", price: 0)])
  private let disposeBag = DisposeBag()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "검색 결과"
    label.font = .systemFont(ofSize: 24, weight: .bold)
    return label
  }()

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)

      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 0
      section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)

      return section
    }

    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(BookCell.self, forCellWithReuseIdentifier: BookCell.reuseIdentifier)
    cv.backgroundColor = .clear
    cv.showsVerticalScrollIndicator = false

    return cv
  }()

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

extension BookListView {
  private func setupConfigures() {
    backgroundColor = .white
  }

  private func setupViews() {
    [
      titleLabel,
      collectionView
    ]
      .forEach {
        addSubview($0)
      }

    setupConstraints()
  }

  private func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(20)
    }
    collectionView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom).offset(15)
    }
  }

  private func bind() {
    bookRelay.bind(to: collectionView.rx.items(cellIdentifier: BookCell.reuseIdentifier, cellType: BookCell.self)) { index, element, cell in
      cell.configure(book: element)
    }
    .disposed(by: disposeBag)

    collectionView.rx.modelSelected(String.self)
      .subscribe(onNext: { item in
        print("Selected \(item)")
      })
      .disposed(by: disposeBag)
  }
}

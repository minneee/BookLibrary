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

final class BookListView: UIView {
  let selectedBook = PublishRelay<Book>()

  let bookRelay: BehaviorRelay<[Book]> = .init(value: [])
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

  private let emptyView: UIView = {
    let view = UIView()
    let label = UILabel()
    label.text = "검색 결과가 없습니다."
    label.font = .systemFont(ofSize: 18, weight: .medium)
    label.textColor = .lightGray
    label.textAlignment = .center
    view.addSubview(label)
    label.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    return view
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
      collectionView,
      emptyView
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

    emptyView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom).offset(15)
    }
  }

  private func bind() {
    bookRelay.bind(to: collectionView.rx.items(cellIdentifier: BookCell.reuseIdentifier, cellType: BookCell.self)) { index, element, cell in
      cell.configure(book: element)
    }
    .disposed(by: disposeBag)

    collectionView.rx.modelSelected(Book.self)
      .bind(to: selectedBook)
      .disposed(by: disposeBag)

    bookRelay
      .map { $0.isEmpty }
      .distinctUntilChanged()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] isEmpty in
        guard let self else { return }
        UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve) {
          self.emptyView.isHidden = !isEmpty
          self.collectionView.isHidden = isEmpty
        }
      })
      .disposed(by: disposeBag)
  }
}

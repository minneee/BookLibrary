//
//  SearchViewController.swift
//  BookLibrary
//
//  Created by 김민희 on 10/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
  private let disposeBag = DisposeBag()

  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "책 제목이나 작가 이름으로 검색하세요"
    searchBar.searchBarStyle = .minimal
    return searchBar
  }()

  private let recentlyReadBooks = RecentlyReadBooks()

  private let bookListView = BookListView()

  private let viewModel: SearchViewModel
  private let useCase: SavedBooksUseCaseProtocol

  init(viewModel: SearchViewModel, useCase: SavedBooksUseCaseProtocol) {
    self.viewModel = viewModel
    self.useCase = useCase
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupConfigures()
    setupViews()
    bind()

    recentlyReadBooks.bookColors.accept([.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemRed, .systemOrange, .systemYellow, .systemGreen, .systemRed, .systemOrange, .systemYellow, .systemGreen])
  }

  private func setupConfigures() {
    view.backgroundColor = .white
    navigationController?.isNavigationBarHidden = true
  }

  private func setupViews() {
    [
      searchBar,
      recentlyReadBooks,
      bookListView
    ]
      .forEach {
        view.addSubview($0)
      }

    setupConstraints()
  }

  private func setupConstraints() {
    searchBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview().inset(20)
    }

    recentlyReadBooks.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom).offset(12)
      make.leading.trailing.equalToSuperview()
      make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
    }

    bookListView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(recentlyReadBooks.snp.bottom).offset(30)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }

  private func bind() {
    let input = SearchViewModel.Input(
      searchText: searchBar.rx.text.orEmpty.asDriver()
    )

    let output = viewModel.transform(input: input)

    output.books
      .drive(bookListView.bookRelay)
      .disposed(by: disposeBag)

    output.error
      .drive { [weak self] message in
        guard !message.isEmpty else { return }
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self?.present(alert, animated: true)
      }
      .disposed(by: disposeBag)

    bookListView.selectedBook
      .subscribe { [weak self] book in
        guard let self else { return }
        let detailVC = BookDetailViewController(book: book, useCase: useCase)

        if let sheet = detailVC.sheetPresentationController {
          sheet.detents = [.large()]
          sheet.prefersGrabberVisible = true
          sheet.preferredCornerRadius = 20
        }
        self.present(detailVC, animated: true)
      }
      .disposed(by: disposeBag)
  }
}


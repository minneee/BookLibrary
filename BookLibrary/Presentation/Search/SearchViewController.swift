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

  private let mainStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 30
    return stack
  }()

  private let searchViewModel: SearchViewModel
  private let recentBooksViewModel: RecentBooksViewModel
  private let saveBookUseCase: SavedBooksUseCaseProtocol
  private let recentBooksUseCase: RecentBooksUseCaseProtocol

  init(searchViewModel: SearchViewModel, recentBooksViewModel: RecentBooksViewModel, saveBookUseCase: SavedBooksUseCaseProtocol, recentBooksUseCase: RecentBooksUseCaseProtocol) {
    self.searchViewModel = searchViewModel
    self.recentBooksViewModel = recentBooksViewModel
    self.saveBookUseCase = saveBookUseCase
    self.recentBooksUseCase = recentBooksUseCase
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
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    recentBooksViewModel.fetchRecentBooks()
  }

  private func setupConfigures() {
    view.backgroundColor = .white
    navigationController?.isNavigationBarHidden = true
  }

  private func setupViews() {
    [
      searchBar,
      mainStackView
    ]
      .forEach {
        view.addSubview($0)
      }

    [
      recentlyReadBooks,
      bookListView
    ]
      .forEach {
        mainStackView.addArrangedSubview($0)
      }

    setupConstraints()
  }

  private func setupConstraints() {
    searchBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview().inset(20)
    }

    mainStackView.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom).offset(20)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }

  private func bind() {
    let loadNextPageTrigger = bookListView.collectionView.rx.didScroll
      .asDriver()
      .filter { [weak self] in
        guard let self = self else { return false }
        let offsetY = self.bookListView.collectionView.contentOffset.y
        let contentHeight = self.bookListView.collectionView.contentSize.height
        let height = self.bookListView.collectionView.frame.size.height
        return offsetY > contentHeight - height - 100
      }
      .map { _ in () }

    let input = SearchViewModel.Input(
      searchText: searchBar.rx.text.orEmpty.asDriver(),
      loadNextPageTrigger: loadNextPageTrigger
    )

    let output = searchViewModel.transform(input: input)

    output.books
      .drive(bookListView.bookRelay)
      .disposed(by: disposeBag)

    output.error
      .drive(onNext: { [weak self] message in
        guard !message.isEmpty else { return }
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self?.present(alert, animated: true)
      })
      .disposed(by: disposeBag)

    recentBooksViewModel.recentBooks
      .drive(onNext: { [weak self] books in
        guard let self = self else { return }
        self.recentlyReadBooks.update(with: books)
      })
      .disposed(by: disposeBag)

    bookListView.selectedBook
      .subscribe { [weak self] book in
        guard let self else { return }
        let detailVC = BookDetailViewController(book: book, savedBooksUseCase: saveBookUseCase, recentBooksUseCase: recentBooksUseCase)

        if let sheet = detailVC.sheetPresentationController {
          sheet.detents = [.large()]
          sheet.prefersGrabberVisible = true
          sheet.preferredCornerRadius = 20
        }
        self.present(detailVC, animated: true)
      }
      .disposed(by: disposeBag)

    NotificationCenter.default.rx.notification(.didDismissDetail)
      .subscribe(onNext: { [weak self] _ in
        self?.recentBooksViewModel.fetchRecentBooks()
      })
      .disposed(by: disposeBag)

  }
}


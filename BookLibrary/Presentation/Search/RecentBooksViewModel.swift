//
//  RecentBooksViewModel.swift
//  BookLibrary
//
//  Created by 김민희 on 10/30/25.
//


import RxSwift
import RxCocoa

final class RecentBooksViewModel {
  private let useCase: RecentBooksUseCaseProtocol
  private let disposeBag = DisposeBag()

  private let _recentBooks = BehaviorRelay<[Book]>(value: [])
  var recentBooks: Driver<[Book]> { _recentBooks.asDriver() }

  init(useCase: RecentBooksUseCaseProtocol) {
    self.useCase = useCase
  }

  func fetchRecentBooks() {
    useCase.fetchRecentBooks(limit: 5)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] books in
        self?._recentBooks.accept(books)
      })
      .disposed(by: disposeBag)
  }
}

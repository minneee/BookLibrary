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

  private let fetchTrigger = PublishRelay<Void>()

  init(useCase: RecentBooksUseCaseProtocol) {
    self.useCase = useCase

    fetchTrigger
      .flatMapLatest { [useCase] in
        useCase.fetchRecentBooks(limit: 5)
          .catchAndReturn([])
      }
      .observe(on: MainScheduler.instance)
      .bind(to: _recentBooks)
      .disposed(by: disposeBag)
  }

  func fetchRecentBooks() {
    fetchTrigger.accept(())
  }
}

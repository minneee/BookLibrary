//
//  SearchViewModel.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import RxSwift
import RxCocoa
import Foundation

final class SearchViewModel {
  struct Input {
    let searchText: Driver<String>
    let loadNextPageTrigger: Driver<Void>
  }

  struct Output {
    let books: Driver<[Book]>
    let error: Driver<String>
  }

  private let disposeBag = DisposeBag()
  private let useCase: SearchBooksUseCaseProtocol

  private var currentQuery: String = ""
  private var currentPage: Int = 1
  private var isEnd: Bool = false
  private var allBooks: [Book] = []
  private let pageSize: Int = 20

  init(useCase: SearchBooksUseCaseProtocol) {
    self.useCase = useCase
  }

  func transform(input: Input) -> Output {
    let errorSubject = PublishSubject<String>()
    let booksRelay = BehaviorRelay<[Book]>(value: [])

    input.searchText
      .skip(1)
      .debounce(.milliseconds(300))
      .distinctUntilChanged()
      .drive(onNext: { [weak self] query in
        guard let self = self, !query.isEmpty else { return }
        self.currentQuery = query
        self.currentPage = 1
        self.isEnd = false
        self.allBooks = []
        self.fetchBooks(booksRelay: booksRelay, errorSubject: errorSubject)
      })
      .disposed(by: disposeBag)

    input.loadNextPageTrigger
      .drive(onNext: { [weak self] in
        guard let self = self else { return }
        guard !self.isEnd else { return }
        self.currentPage += 1
        self.fetchBooks(booksRelay: booksRelay, errorSubject: errorSubject)
      })
      .disposed(by: disposeBag)

    return Output(
      books: booksRelay.asDriver(),
      error: errorSubject.asDriver(onErrorJustReturn: "Unknown Error")
    )
  }

  private func fetchBooks(booksRelay: BehaviorRelay<[Book]>, errorSubject: PublishSubject<String>) {
    useCase.execute(query: currentQuery, page: currentPage, size: pageSize)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(
        onSuccess: { [weak self] response in
          guard let self = self else { return }
          self.isEnd = response.isEnd
          self.allBooks.append(contentsOf: response.books)
          booksRelay.accept(self.allBooks)
        },
        onFailure: { error in
          errorSubject.onNext(error.localizedDescription)
        }
      )
      .disposed(by: disposeBag)
  }
}

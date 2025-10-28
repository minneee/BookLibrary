//
//  SearchViewModel.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import RxSwift
import RxCocoa

final class SearchViewModel {
  struct Input {
    let searchText: Driver<String>
  }

  struct Output {
    let books: Driver<[Book]>
    let error: Driver<String>
  }

  private let disposeBag = DisposeBag()
  private let useCase: SearchBooksUseCaseProtocol

  init(useCase: SearchBooksUseCaseProtocol) {
    self.useCase = useCase
  }

  func transform(input: Input) -> Output {
    let searchResult = input.searchText
      .flatMapLatest { query in
        useCase.execute(query: query)
          .asObservable()
          .materialize()
      }
      .share()

    let books = searchResult
      .compactMap { $0.element }
      .asDriver(onErrorJustReturn: [])

    let error = searchResult
      .compactMap { $0.error }
      .map { $0.localizedDescription }
      .asDriver(onErrorJustReturn: "Unknown error")

    return Output(books: books, error: error)
  }
}

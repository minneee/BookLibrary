//
//  SearchBooksUseCase.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import RxSwift

protocol SearchBooksUseCaseProtocol {
  func execute(query: String, page: Int, size: Int) -> Single<BookSearch>
}

final class SearchBooksUseCase: SearchBooksUseCaseProtocol {
  private let repository: BookRepositoryProtocol

  init(repository: BookRepositoryProtocol) {
    self.repository = repository
  }

  func execute(query: String, page: Int, size: Int) -> Single<BookSearch> {
    repository.searchBooks(query: query, page: page, size: size)
  }
}

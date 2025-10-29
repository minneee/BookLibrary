//
//  SearchBooksUseCase.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import RxSwift

protocol SearchBooksUseCaseProtocol {
  func execute(query: String) -> Single<[Book]>
}

final class SearchBooksUseCase: SearchBooksUseCaseProtocol {
  private let repository: BookRepositoryProtocol

  init(repository: BookRepositoryProtocol) {
    self.repository = repository
  }

  func execute(query: String) -> Single<[Book]> {
    repository.searchBooks(query: query)
  }
}

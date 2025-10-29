//
//  SavedBooksUseCase.swift
//  BookLibrary
//
//  Created by 김민희 on 10/29/25.
//

import RxSwift

protocol SavedBooksUseCaseProtocol {
  func fetchBooks() -> Observable<[Book]>
  func saveBook(_ book: Book)
  func deleteBook(_ book: Book)
  func deleteAllBooks()
}

final class SavedBooksUseCase: SavedBooksUseCaseProtocol {
  private let repository: SavedBookRepositoryProtocol

  init(repository: SavedBookRepositoryProtocol = SavedBookRepository()) {
    self.repository = repository
  }

  func fetchBooks() -> Observable<[Book]> {
    repository.fetchBooks()
  }

  func saveBook(_ book: Book) {
    repository.saveBook(book)
  }

  func deleteBook(_ book: Book) {
    repository.deleteBook(book)
  }

  func deleteAllBooks() {
    repository.deleteAllBooks()
  }
}

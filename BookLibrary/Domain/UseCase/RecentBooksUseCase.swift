//
//  RecentBooksUseCase.swift
//  BookLibrary
//
//  Created by 김민희 on 10/30/25.
//


import RxSwift

protocol RecentBooksUseCaseProtocol {
  func fetchRecentBooks(limit: Int) -> Observable<[Book]>
  func addRecentBook(_ book: Book)
}

final class RecentBooksUseCase: RecentBooksUseCaseProtocol {
  private let repository: RecentBookRepositoryProtocol
  
  init(repository: RecentBookRepositoryProtocol = RecentBookRepository()) {
    self.repository = repository
  }
  
  func fetchRecentBooks(limit: Int = 5) -> Observable<[Book]> {
    repository.fetchRecentBooks(limit: limit)
  }
  
  func addRecentBook(_ book: Book) {
    repository.addRecentBook(book)
  }
}

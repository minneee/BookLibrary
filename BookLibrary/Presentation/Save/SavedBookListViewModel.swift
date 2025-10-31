//
//  SavedBookListViewModel.swift
//  BookLibrary
//
//  Created by 김민희 on 10/29/25.
//

import RxSwift
import RxCocoa
import Foundation

final class SavedBookListViewModel {
  let useCase: SavedBooksUseCaseProtocol
  private let disposeBag = DisposeBag()

  let books = BehaviorRelay<[Book]>(value: [])
  let isEmpty = BehaviorRelay<Bool>(value: false)
  let error = PublishRelay<String>()

  init(useCase: SavedBooksUseCaseProtocol) {
    self.useCase = useCase
  }

  func fetchBooks() {
    useCase.fetchBooks()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] list in
        self?.books.accept(list)
        self?.isEmpty.accept(list.isEmpty)
      }, onError: { [weak self] error in
        self?.error.accept(error.localizedDescription)
      })
      .disposed(by: disposeBag)
  }

  func deleteBook(_ book: Book) {
    useCase.deleteBook(book)
    fetchBooks()
  }

  func deleteAllBooks() {
    useCase.deleteAllBooks()
    fetchBooks()
  }
}

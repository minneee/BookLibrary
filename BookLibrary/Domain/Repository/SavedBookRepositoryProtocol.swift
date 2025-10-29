//
//  SavedBookRepositoryProtocol.swift
//  BookLibrary
//
//  Created by 김민희 on 10/29/25.
//

import Foundation
import RxSwift

protocol SavedBookRepositoryProtocol {
  func fetchBooks() -> Observable<[Book]>
  func saveBook(_ book: Book)
  func deleteBook(_ book: Book)
  func deleteAllBooks()
}

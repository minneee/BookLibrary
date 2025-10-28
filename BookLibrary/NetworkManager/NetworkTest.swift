//
//  NetworkTest.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//


import Foundation
import RxSwift

final class NetworkTest {
  private let disposeBag = DisposeBag()

  func runTest() {
    let repository = BookRepository()

    repository.searchBooks(query: "클린 아키텍처")
      .subscribe(
        onSuccess: { books in
          print("✅ 검색 결과 \(books.count)개")
          for book in books.prefix(3) { // 처음 3개만 출력
            print("📘 \(book.title) / \(book.authors)")
          }
        },
        onFailure: { error in
          print("❌ API 호출 실패:", error)
        }
      )
      .disposed(by: disposeBag)
  }
}

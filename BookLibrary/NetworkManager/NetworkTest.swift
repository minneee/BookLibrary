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

    repository.searchBooks(query: "클린 아키텍처", page: 1, size: 20)
      .subscribe(
        onSuccess: { response in
          let books = response.books
          print("✅ 검색 결과 \(books.count)개")
          print("📄 마지막 페이지 여부: \(response.isEnd ? "✅ 마지막 페이지" : "⏭ 다음 페이지 있음")")

          for book in books.prefix(3) {
            print("📘 \(book.title) / \(book.authors.joined(separator: ","))")
          }
        },
        onFailure: { error in
          print("❌ API 호출 실패:", error)
        }
      )
      .disposed(by: disposeBag)
  }
}

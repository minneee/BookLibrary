//
//  BookRepository.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import RxSwift

final class BookRepository: BookRepositoryProtocol {
  func searchBooks(query: String, page: Int, size: Int) -> Single<BookSearch> {
    let api = BookAPI.search(query: query, sort: nil, page: page, size: size, target: nil)

    return APIClient.shared.request(api)
      .map { (response: BookSearchResponseDTO) in
        response.toDomain()
      }
  }
}


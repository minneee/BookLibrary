//
//  BookRepository.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import RxSwift

final class BookRepository: BookRepositoryProtocol {
  func searchBooks(query: String) -> Single<[Book]> {
    let api = BookAPI.search(query: query, sort: nil, page: 1, size: 20, target: nil)
    
    return APIClient.shared.request(api.url, method: api.method, parameters: api.parameters)
      .map { (response: BookSearchResponseDTO) in
        response.documents.map { $0.toDomain() }
      }
  }
}


//
//  BookRepository.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import RxSwift

final class BookRepository: BookRepositoryProtocol {
  func searchBooks(query: String, page: Int, size: Int) -> Single<BookSearch> {
    let requestDTO = BookSearchRequestDTO(
      query: query,
      sort: nil,
      page: page,
      size: size,
      target: nil
    )
    
    let api = BookAPI.search(requestDTO)
    
    return APIClient.shared.request(api)
      .map { (response: BookSearchResponseDTO) in
        response.toDomain()
      }
  }
}


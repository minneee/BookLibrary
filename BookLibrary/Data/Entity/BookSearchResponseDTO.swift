//
//  BookSearchResponseDTO.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//


import Foundation

struct BookSearchResponseDTO: Codable {
  let documents: [BookDTO]
  let meta: MetaDTO
}

struct MetaDTO: Codable {
  let totalCount: Int
  let pageableCount: Int
  let isEnd: Bool

  enum CodingKeys: String, CodingKey {
    case totalCount = "total_count"
    case pageableCount = "pageable_count"
    case isEnd = "is_end"
  }
}

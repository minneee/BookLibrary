//
//  BookDTO.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//


import Foundation

struct BookDTO: Codable {
  let title: String
  let contents: String
  let url: String
  let isbn: String
  let datetime: String
  let authors: [String]
  let publisher: String
  let translators: [String]
  let price: Int
  let salePrice: Int
  let thumbnail: String
  let status: String

  enum CodingKeys: String, CodingKey {
    case title, contents, url, isbn, datetime, authors, publisher, translators, price, thumbnail, status
    case salePrice = "sale_price"
  }
}

extension BookDTO {
  func toDomain() -> Book {
    return Book(title: title, contents: contents, authors: authors, thumbnail: thumbnail, price: price)
  }
}

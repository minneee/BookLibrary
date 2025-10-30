//
//  Book.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import Foundation

struct Book: Decodable {
  let title: String
  let contents: String
  let authors: [String]
  let thumbnail: String?
  let price: Int
}

extension Book {
  init(entity: BookEntity) {
    self.title = entity.title ?? ""
    self.contents = entity.contents ?? ""
    self.authors = entity.authors?.components(separatedBy: ", ") ?? []
    self.thumbnail = entity.thumbnail
    self.price = Int(entity.price)
  }

  init(recentEntity: RecentBookEntity) {
    self.title = recentEntity.title ?? ""
    self.contents = recentEntity.contents ?? ""
    self.authors = recentEntity.authors?.components(separatedBy: ", ") ?? []
    self.thumbnail = recentEntity.thumbnail
    self.price = Int(recentEntity.price)
  }
}

//
//  Book.swift
//  BookLibrary
//
//  Created by 김민희 on 10/27/25.
//

import Foundation

struct Book: Hashable, Sendable {
  let title: String
  let contents: String
  let authors: [String]
  let thumbnail: String?
  let price: Int
}

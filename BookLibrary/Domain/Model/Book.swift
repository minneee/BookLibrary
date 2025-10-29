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

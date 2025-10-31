//
//  BookSearchRequestDTO.swift
//  BookLibrary
//
//  Created by 김민희 on 10/30/25.
//

import Foundation

struct BookSearchRequestDTO: Encodable {
  let query: String
  let sort: String?
  let page: Int
  let size: Int
  let target: String?
}

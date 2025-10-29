//
//  BookRepositoryProtocol.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import RxSwift

protocol BookRepositoryProtocol {
  func searchBooks(query: String) -> Single<[Book]>
}


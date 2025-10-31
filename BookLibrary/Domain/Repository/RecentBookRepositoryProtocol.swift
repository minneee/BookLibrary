//
//  RecentBookRepositoryProtocol.swift
//  BookLibrary
//
//  Created by 김민희 on 10/30/25.
//

import Foundation
import RxSwift

protocol RecentBookRepositoryProtocol {
  func fetchRecentBooks(limit: Int) -> Observable<[Book]>
  func addRecentBook(_ book: Book)
}

//
//  BookAPI.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import Foundation
import Alamofire

enum BookAPI {
  case search(query: String, sort: String?, page: Int?, size: Int?, target: String?)
  
  var path: String { "/v3/search/book" }
  var method: HTTPMethod { .get }
  
  var parameters: Parameters {
    switch self {
    case let .search(query, sort, page, size, target):
      var params: Parameters = ["query": query]
      if let sort = sort { params["sort"] = sort }
      if let page = page { params["page"] = page }
      if let size = size { params["size"] = size }
      if let target = target { params["target"] = target }
      return params
    }
  }
  
  var url: String {
    return APIConstant.baseURL + path
  }
}

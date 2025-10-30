//
//  BookAPI.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import Foundation
import Alamofire

enum BookAPI {
  case search(BookSearchRequestDTO)
}

extension BookAPI: URLRequestConvertible {
  var path: String {
    switch self {
    case .search: return "/v3/search/book"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .search:
      return .get
    }
  }

  var url: URL {
    return URL(string: APIConstant.baseURL + path)!
  }

  func asURLRequest() throws -> URLRequest {
    var request = try URLRequest(url: url, method: method)
    request.setValue("KakaoAK \(APIKeyManager.kakao)", forHTTPHeaderField: "Authorization")

    switch self {
    case .search(let requestDTO):
      request = try URLEncodedFormParameterEncoder(destination: .methodDependent)
        .encode(requestDTO, into: request)
    }

    return request
  }
}

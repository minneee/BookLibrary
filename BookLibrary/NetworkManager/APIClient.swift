//
//  APIClient.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import Alamofire
import RxSwift
import Foundation

final class APIClient {
  static let shared = APIClient()
  private let session: Session

  private init() {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    self.session = Session(configuration: configuration)
  }

  func request<T: Decodable>(
    _ url: URLConvertible,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil
  ) -> Single<T> {
    let headers: HTTPHeaders = [
      "Authorization": "KakaoAK \(APIKeyManager.kakao)"
    ]

    return Single.create { single in
      let request = self.session.request(
        url,
        method: method,
        parameters: parameters,
        encoding: URLEncoding.default,
        headers: headers
      ).validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
          switch response.result {
          case .success(let value):
            single(.success(value))
          case .failure(let error):
            single(.failure(error))
          }
        }

      return Disposables.create { request.cancel() }
    }
  }
}

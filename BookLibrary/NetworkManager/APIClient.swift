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
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 30
    session = Session(configuration: config)
  }
  
  func request<T: Decodable>(_ api: URLRequestConvertible) -> Single<T> {
    Single.create { observer in
      let request = self.session.request(api)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
          switch response.result {
          case .success(let value): observer(.success(value))
          case .failure(let error): observer(.failure(error))
          }
        }
      
      return Disposables.create { request.cancel() }
    }
  }
}

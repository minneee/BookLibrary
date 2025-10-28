//
//  APIKeyManager.swift
//  BookLibrary
//
//  Created by 김민희 on 10/28/25.
//

import Foundation

enum APIKeyManager {
  static var kakao: String {
    guard let key = Bundle.main.object(forInfoDictionaryKey: "KAKAO_API_KEY") as? String else {
      fatalError("❌ KAKAO_API_KEY not found in Info.plist or xcconfig")
    }
    return key
  }
}

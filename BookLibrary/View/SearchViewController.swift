//
//  SearchViewController.swift
//  BookLibrary
//
//  Created by 김민희 on 10/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
  private let disposeBag = DisposeBag()

  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "책 제목이나 작가 이름으로 검색하세요"
    searchBar.searchBarStyle = .minimal
    return searchBar
  }()

  private let recentlyReadBooks = RecentlyReadBooks()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupConfigures()
    setupViews()

    recentlyReadBooks.bookColors.accept([.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemRed, .systemOrange, .systemYellow, .systemGreen, .systemRed, .systemOrange, .systemYellow, .systemGreen])
  }

  private func setupConfigures() {
    view.backgroundColor = .white
    navigationController?.isNavigationBarHidden = true
  }

  private func setupViews() {
    [
      searchBar,
      recentlyReadBooks
    ]
      .forEach {
        view.addSubview($0)
      }

    setupConstraints()
  }

  private func setupConstraints() {
    searchBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview().inset(20)
    }
    recentlyReadBooks.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom).offset(12)
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
    }
  }
}


//
//  SavedBookListViewController.swift
//  BookLibrary
//
//  Created by 김민희 on 10/24/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SavedBookListViewController: UIViewController {
  private var viewModel: SavedBookListViewModel
  private let disposeBag = DisposeBag()

  private let tableView = UITableView()

  private let emptyLabel: UILabel = {
    let label = UILabel()
    label.text = "저장된 책이 없습니다."
    label.textAlignment = .center
    label.textColor = .gray
    label.isHidden = true
    return label
  }()

  init(viewModel: SavedBookListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupConfigures()
    setupViews()
    bind()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchBooks()
  }

  private func setupConfigures() {
    view.backgroundColor = .white
    title = "내 서재"

    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "전체 삭제",
      style: .plain,
      target: self,
      action: #selector(deleteAllTapped)
    )
    navigationItem.leftBarButtonItem?.tintColor = .systemRed

    tableView.register(SavedBookCell.self, forCellReuseIdentifier: SavedBookCell.reuseIdentifier)
    tableView.rowHeight = 100
  }

  private func setupViews() {
    [
      tableView,
      emptyLabel
    ]
      .forEach { view.addSubview($0) }

    setupConstraints()
  }

  private func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.trailing.bottom.equalToSuperview()
    }
    emptyLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }

  private func bind() {
    // 리스트 바인딩
    viewModel.books
      .asObservable()
      .bind(to: tableView.rx.items(cellIdentifier: SavedBookCell.reuseIdentifier, cellType: SavedBookCell.self)) { _, book, cell in
        cell.configure(book: book)
      }
      .disposed(by: disposeBag)

    // Empty 상태
    viewModel.isEmpty
      .map { !$0 }
      .bind(to: emptyLabel.rx.isHidden)
      .disposed(by: disposeBag)

    // 스와이프 삭제
    tableView.rx.itemDeleted
      .withLatestFrom(viewModel.books) { ($0, $1) }
      .bind { [weak self] (indexPath, books) in
        self?.viewModel.deleteBook(books[indexPath.row])
      }
      .disposed(by: disposeBag)
  }

  @objc private func deleteAllTapped() {
     showDeleteAllAlert()
   }

  private func showDeleteAllAlert() {
    let alert = UIAlertController(title: "전체 삭제",
                                  message: "모든 책을 삭제하시겠습니까?",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "취소", style: .cancel))
    alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
      self?.viewModel.deleteAllBooks()
    }))
    present(alert, animated: true)
  }
}

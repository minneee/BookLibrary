//
//  RecentBookRepository.swift
//  BookLibrary
//
//  Created by 김민희 on 10/30/25.
//

import Foundation
import CoreData
import RxSwift

final class RecentBookRepository: RecentBookRepositoryProtocol {
  private let context = CoreDataManager.shared.context

  func fetchRecentBooks(limit: Int = 5) -> Observable<[Book]> {
    return Observable.create { observer in
      let request: NSFetchRequest<RecentBookEntity> = RecentBookEntity.fetchRequest()
      let sortDescriptor = NSSortDescriptor(key: "viewedDate", ascending: false)
      request.sortDescriptors = [sortDescriptor]
      request.fetchLimit = limit

      do {
        let entities = try self.context.fetch(request)
        let books = entities.map { Book(recentEntity: $0) }
        observer.onNext(books)
        observer.onCompleted()
      } catch {
        observer.onError(error)
      }
      return Disposables.create()
    }
  }

  func addRecentBook(_ book: Book) {
    let request: NSFetchRequest<RecentBookEntity> = RecentBookEntity.fetchRequest()
    request.predicate = NSPredicate(format: "title == %@", book.title)
    if let existing = try? context.fetch(request).first {
      context.delete(existing)
    }

    let entity = RecentBookEntity(context: context)
    entity.title = book.title
    entity.contents = book.contents
    entity.authors = book.authors.joined(separator: ", ")
    entity.thumbnail = book.thumbnail
    entity.price = Int64(book.price)
    entity.viewedDate = Date()

    CoreDataManager.shared.saveContext()

    trimToLimit()
  }

  private func trimToLimit(_ limit: Int = 5) {
    let request: NSFetchRequest<RecentBookEntity> = RecentBookEntity.fetchRequest()
    let sort = NSSortDescriptor(key: "viewedDate", ascending: false)
    request.sortDescriptors = [sort]

    if let results = try? context.fetch(request), results.count > limit {
      let extras = results.suffix(from: limit)
      extras.forEach { context.delete($0) }
      CoreDataManager.shared.saveContext()
    }
  }
}

//
//  SavedBookRepository.swift
//  BookLibrary
//
//  Created by 김민희 on 10/29/25.
//
import Foundation
import CoreData
import RxSwift

final class SavedBookRepository: SavedBookRepositoryProtocol {
  private let context = CoreDataManager.shared.context

  func fetchBooks() -> Observable<[Book]> {
    return Observable.create { observer in
      let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
      do {
        let entities = try self.context.fetch(request)
        let books = entities.map { Book(entity: $0) }
        observer.onNext(books)
        observer.onCompleted()
      } catch {
        observer.onError(error)
      }
      return Disposables.create()
    }
  }

  func saveBook(_ book: Book) {
    let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
    request.predicate = NSPredicate(format: "title == %@", book.title)
    
    if let existing = try? context.fetch(request).first {
      context.delete(existing)
    }

    let entity = BookEntity(context: context)
    entity.title = book.title
    entity.contents = book.contents
    entity.authors = book.authors.joined(separator: ", ")
    entity.thumbnail = book.thumbnail
    entity.price = Int64(book.price)
    CoreDataManager.shared.saveContext()
  }

  func deleteBook(_ book: Book) {
    let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
    request.predicate = NSPredicate(format: "title == %@", book.title)

    do {
      let results = try context.fetch(request)
      if let entity = results.first {
        context.delete(entity)
        CoreDataManager.shared.saveContext()
      }
    } catch {
      print("❌ Delete Error: \(error)")
    }
  }

  func deleteAllBooks() {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = BookEntity.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try context.execute(deleteRequest)
      CoreDataManager.shared.saveContext()
    } catch {
      print("❌ 전체 삭제 실패: \(error)")
    }
  }
}

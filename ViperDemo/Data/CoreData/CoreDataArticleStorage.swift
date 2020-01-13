//
//  CoreDataArticleStorage.swift
//  ViperDemo
//
//  Created by Hongli Yu on 08.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import CoreData

final class CoreDataArticleStorage: ArticleDataStorage {

    private let manager: CoreDataManager

    init(manager: CoreDataManager) {
        self.manager = manager
    }

    // MARK: ArticleDataStorage
    func store(_ article: Article, completion: @escaping (Error?) -> Void) {
        guard let title = article.title else { return }
        manager.persistentContainer.performBackgroundTask { context in
            do {
                let entity: ArticleEntity
                if let storedEntity = try self.fetch(title, inContext: context) {
                    entity = storedEntity
                } else {
                    entity = ArticleEntity(context: context)
                }
                try entity.populate(with: article)
                try context.save()
                completion(nil)
            } catch let error {
                assertionFailure("\(#file):\(#line) Coredata failure: \(error)")
                context.rollback()
                completion(error)
            }
        }
    }

    func store(_ articles: [Article], completion: @escaping (Error?) -> Void) {
        manager.persistentContainer.performBackgroundTask { context in
            do {
                for article in articles {
                    guard let title = article.title else { continue }
                    let entity: ArticleEntity
                    if let storedEntity = try self.fetch(title, inContext: context) {
                        entity = storedEntity
                    } else {
                        entity = ArticleEntity(context: context)
                    }
                    try entity.populate(with: article)
                }
                try context.save()
                completion(nil)
            } catch {
                assertionFailure("\(#file):\(#line) Coredata failure: \(error)")
                context.rollback()
                completion(error)
            }
        }
    }

    func load(from: Date, completion: @escaping (ArticleDataStorageResult<[Article]>) -> Void) {
        manager.persistentContainer.performBackgroundTask { context in
            let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
            request.predicate = NSPredicate(format: "%@ <= publishedAt", from as NSDate)
            do {
                let results = try context.fetch(request)
                let articles = results.compactMap { entity -> Article? in
                    return entity.convertToBO()
                }
                completion(.success(articles))
            } catch let error {
                completion(.failure(error))
            }
        }
    }

    func loadRecent(numerOfItems: Int, completion: @escaping (ArticleDataStorageResult<[Article]>) -> Void) {
        manager.persistentContainer.performBackgroundTask { context in
            let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
            request.fetchLimit = numerOfItems
            request.sortDescriptors = [NSSortDescriptor(key: "publishedAt", ascending: false)]
            do {
                let results = try context.fetch(request)
                let articles = results.compactMap { entity -> Article? in
                    return entity.convertToBO()
                }
                completion(.success(articles))
            } catch let error {
                completion(.failure(error))
            }
        }
    }

    private func fetch(_ title: String, inContext context: NSManagedObjectContext) throws -> ArticleEntity? {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        request.fetchLimit = 1
        let results = try context.fetch(request)
        return results.first
    }

}

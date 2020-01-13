//
//  ArticleDataStorage.swift
//  ViperDemo
//
//  Created by Hongli Yu on 08.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

enum ArticleDataStorageResult<T> {
    case success(T)
    case failure(Error?)
}

protocol ArticleDataStorage {
    func store(_ article: Article, completion: @escaping (Error?) -> Void)
    func store(_ articles: [Article], completion: @escaping (Error?) -> Void)
    func load(from: Date, completion: @escaping (ArticleDataStorageResult<[Article]>) -> Void)
    func loadRecent(numerOfItems: Int, completion: @escaping (ArticleDataStorageResult<[Article]>) -> Void)
}

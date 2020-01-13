//
//  NewsService.swift
//  ViperDemo
//
//  Created by Hongli Yu on 03.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

enum NewsServiceResult<T> {
    case success(T)
    case failure(Error?)
}

typealias NewsListCompletion = (NewsServiceResult<ArticleList>) -> Void

protocol NewsService: EndpointService {
    func fetchNews(completion: @escaping NewsListCompletion)
}

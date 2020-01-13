//
//  NewsServiceImpl.swift
//  ViperDemo
//
//  Created by Hongli Yu on 03.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

final class NewsServiceImpl: NewsService {

    lazy var webService: WebService = WebServiceImpl()

    private enum Endpoints {
        static let topHeadlines = "/v2/top-headlines"
    }

    func fetchNews(completion: @escaping NewsListCompletion) {
        let endpoint = String(format: Endpoints.topHeadlines)

        let validator = NewsStatusCodeValidator()
        let meta = RequestMetaImpl(isUserInitiated: false,
                                   statusCodeValidator: validator)
        let queryItems = [URLQueryItem(name: "country", value: "us"),
                          URLQueryItem(name: "apiKey", value: Secrets.apiKey)]
        webService.call(endpoint: endpoint,
                        queryItems: queryItems,
                        body: nil,
                        method: .get,
                        meta: meta) { result in
                            switch result {
                            case .success(let data, _):
                                do {
                                    let decoder = JSONDecoderEncoderBuilder().buildDecoder()
                                    let articleList = try decoder.decode(ArticleList.self, from: data)
                                    completion(.success(articleList))
                                } catch let error {
                                    completion(.failure(error))
                                }
                            case .failure(let error):
                                completion(.failure(error))
                            }
        }
    }

}

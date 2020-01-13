//
//  ArticleEntity+.swift
//  ViperDemo
//
//  Created by Hongli Yu on 08.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import CoreData

extension ArticleEntity: CoreDataEntityConverter {

    func convertToBO() -> Article? {
        return Article(source: source?.convertToBO(), author: author,
                       title: title, desc: desc,
                       url: url, urlToImage: urlToImage,
                       publishedAt: publishedAt, content: content)
    }

    func populate(with object: Article) throws {
        guard let context = managedObjectContext else {
            assertionFailure("\(#file):\(#line) Missing context")
            throw CoreDataConverterError.missingContext
        }
        author = object.author
        content = object.content
        desc = object.desc
        publishedAt = object.publishedAt
        title = object.title
        url = object.url
        urlToImage = object.urlToImage
        if let objectSource = object.source {
            let source = self.source ?? SourceEntity(context: context)
            try source.populate(with: objectSource)
            self.source = source
        }
    }

}

extension SourceEntity: CoreDataEntityConverter {

    func convertToBO() -> Source? {
        guard let identifier = identifier, let name = name else {
            return nil
        }
        return Source(identifier: identifier, name: name)
    }

    func populate(with object: Source) throws {
        identifier = object.identifier
        name = object.name
    }

}

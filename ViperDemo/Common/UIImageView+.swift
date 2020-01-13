//
//  UIImageView+.swift
//  ViperDemo
//
//  Created by Hongli Yu on 09.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                        self.image = downloadedImage
                    }
                }
            }).resume()
        }
    }

}

//
//  ImageCache.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 12/08/23.
//

import SwiftUI

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct DefaultImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(url: URL) -> UIImage? {
        get { cache.object(forKey: url as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: url as NSURL) : cache.setObject(newValue!, forKey: url as NSURL) }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = DefaultImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}

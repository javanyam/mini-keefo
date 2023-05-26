//
//  getURL.swift
//  semi-keefo
//
//  Created by SNAPTAG on 2023/05/25.
//

import Foundation

internal struct getURL{
    let url: URL
    
    init(path: urlPath, parameter: Int) {
        var urlStr = DefaultURL.defaultURL.rawValue
        urlStr = urlStr + path.rawValue + "/\(String(parameter))"
        
        self.url = URL(string: urlStr)!
//        print(url)
    }
}

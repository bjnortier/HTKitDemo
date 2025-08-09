//
//  FileUtils.swift
//  hello
//
//  Created by Ben Nortier on 2023/01/11.
//

import Foundation

enum ResourceError: Error, Equatable, Hashable {
    case resourceNotFound(resource: String, type: String)
}


func getResourcePath(forResource resource: String, ofType type: String) throws -> String {
    guard let path = Bundle.main.path(
        forResource: resource,
        ofType: type
    ) else {
        throw ResourceError.resourceNotFound(resource: resource, type: type)
    }
    return path
}

func getResourceURL(forResource resource: String, withExtension extention: String) throws -> URL {
    guard let url = Bundle.main.url(
        forResource: resource,
        withExtension: extention
    ) else {
        throw ResourceError.resourceNotFound(resource: resource, type: extention)
    }
    return url
}

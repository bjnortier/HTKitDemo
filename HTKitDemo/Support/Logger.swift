//
//  Logger.swift
//  hello
//
//  Created by Ben Nortier on 2023/09/05.
//

import Foundation
import os

extension Logger {
    func error(_ error: Error) {
        self.error("\(error.localizedDescription)")
    }
}

let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: "SwishDemo")
)

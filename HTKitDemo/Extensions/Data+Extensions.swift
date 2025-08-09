//
//  Data+Extensions.swift
//  WhisperMetalDemo
//
//  Created by Ben Nortier on 2025/02/28.
//
import Foundation
import HTKit

extension Data {
    func toFloatArray() throws -> [Float] {
        guard self.count % MemoryLayout<Float>.stride == 0 else {
            throw HTError.invalidMemoryLayout
        }
        return self.withUnsafeBytes { .init($0.bindMemory(to: Float.self)) }
    }
}

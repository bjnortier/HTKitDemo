//
//  SwishDemoError.swift
//  SwishDemo
//
//  Created by Ben Nortier on 2025/05/27.
//

import Foundation

enum SwishDemoError: Error, Equatable, Hashable {
    case nilOutputAudioFormat
    case zeroInputSampleRate
    case noMicInput
    case notImplemented
    case engineNotInitialized
}

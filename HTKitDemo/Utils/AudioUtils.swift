//
//  AudioUtils.swift
//  WhisperMetalDemo
//
//  Created by Ben Nortier on 2025/02/28.
//
import Foundation
import AVFoundation
import HTKit

public func readWAV(_ wavURL: URL) throws -> Data {
    let file = try AVAudioFile(forReading: wavURL)
    guard
        let format = AVAudioFormat(
            commonFormat: .pcmFormatFloat32,
            sampleRate: file.fileFormat.sampleRate,
            channels: 1,
            interleaved: false)
    else {
        throw HTError.audioFormatError
    }
    guard
        let buf = AVAudioPCMBuffer(
            pcmFormat: format, frameCapacity: AVAudioFrameCount(Int(file.length)))
    else {
        throw HTError.bufferCreationError
    }
    try file.read(into: buf)

    guard let floatChannelData = buf.floatChannelData else {
        throw HTError.dataConversionError
    }
    return Data(bytes: floatChannelData[0], count: Int(buf.frameLength * 4))
}

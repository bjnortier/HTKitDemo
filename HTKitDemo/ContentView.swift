//
//  ContentView.swift
//  SwishDemo
//
//  Created by Ben Nortier on 2025/05/26.
//

import AVFoundation
import Combine
import SwiftUI
import HTKit

struct ContentView2: View {
    @State private var error: Error?
    @State private var fileJob: HTFileJob? = nil
    @State private var streamingJob: HTStreamingJob? = nil
    @State private var showMicrophoneDeniedError = false
    @State private var i = 0

    var body: some View {
        NavigationStack {
            VStack {
                Button("File") {
                    do {
                        let dataUrl = try getResourceURL(
                            forResource: "jfk",
                            withExtension: "wav"
                        )
                        let wavData = try readWAV(dataUrl)
                        let samples = try wavData.toFloatArray()
                        fileJob = HTFileJob(samples: samples)
                    } catch {
                        self.error = error
                    }

                }
                .buttonStyle(.borderedProminent)

                Button("Dictate") {
                    Task {
                        let hasPermission = await requestMicrophonePermission()
                        if hasPermission {
                            streamingJob = HTStreamingJob(
                                streamingEngine:
                                    HTMicrophoneStreamingEngine()
                            )
                        } else {
                            showMicrophoneDeniedError = true
                        }
                    }
                }
                .buttonStyle(.borderedProminent)

            }
        }
        .sheet(item: $fileJob) { fileJob in
            FileJobView(job: fileJob)
                .interactiveDismissDisabled()
        }
        .sheet(item: $streamingJob) { fileJob in
            StreamingJobView(job: fileJob)
                .interactiveDismissDisabled()
        }
        .errorAlert(error: $error)
        .alert(
            "Microphone access was denied. Please allow access in Settings",
            isPresented: $showMicrophoneDeniedError
        ) {
            Button("Cancel", role: .cancel) {}
        }
    }

    private func requestMicrophonePermission() async -> Bool {
        #if os(macOS)
            switch AVCaptureDevice.authorizationStatus(for: .audio) {
            case .authorized:
                return true
            case .notDetermined:
                return await withCheckedContinuation { continuation in
                    AVCaptureDevice.requestAccess(for: .audio) { granted in
                        continuation.resume(returning: granted)
                    }
                }
            default:
                return false
            }
        #else
            return await withCheckedContinuation { continuation in
                AVAudioApplication.requestRecordPermission { granted in
                    continuation.resume(returning: granted)
                }
            }
        #endif
    }

}

#Preview {
    ContentView2()
}

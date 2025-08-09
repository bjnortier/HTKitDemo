//
//  StreamingJobView.swift
//  SwishDemo
//
//  Created by Ben Nortier on 2025/06/27.
//

import HTKit
import SwiftUI

struct StreamingJobView: View {
    let job: HTStreamingJob
    @State private var task: Task<Void, Error>? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {

        VStack {
            Text("Job State: \(job.state.rawValue)")
            TranscriptionView(transcription: job.transcription)
            HStack {
                Button(action: {
                    Task {
                        try await job.stop()
                    }
                }) {
                    Label("Stop", systemImage: "square.fill")
                }
                .disabled(job.state != .transcribing)

                Button(action: {
                    Task {
                        try await job.clear()
                    }
                }) {
                    Label("Clear", systemImage: "circle.slash")
                }
                .disabled(job.state != .transcribing)

                Button(action: {
                    Task {
                        dismiss()
                    }

                }) {
                    Label("Delete", systemImage: "trash.fill")
                }
                .disabled(job.state.isBusy)
                .tint(.red)
            }

        }
        .padding()
        .onAppear {
            task = job.start(
                modelPath: try! getResourcePath(
                    forResource: "ggml-tiny",
                    ofType: "bin"
                )
            )
        }
    }
}

private class PreviewStreamingEngine: HTStreamingEngine {
    func startStreaming(buffer: HTStreamingAudioBuffer) throws {
    }

    func pauseStreaming() throws {
    }

    func unpauseStreaming() throws {
    }

    func stopStreaming() throws {
    }
}

#Preview {
    StreamingJobView(
        job: HTStreamingJob(
            streamingEngine: PreviewStreamingEngine()
        )
    )
}

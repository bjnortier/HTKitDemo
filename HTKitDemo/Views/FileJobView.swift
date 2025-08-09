//
//  FileJobView.swift
//  SwishDemo
//
//  Created by Ben Nortier on 2025/06/27.
//

import HTKit
import SwiftUI

struct FileJobView: View {
    let job: HTFileJob
    @State private var task: Task<Void, Error>? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Text("Job State: \(job.state.rawValue)")
            TranscriptionView(transcription: job.transcription)
        }
        .padding()
        .toolbar {
            #if os(iOS)
                let placement = ToolbarItemPlacement.bottomBar
            #elseif os(macOS)
                let placement = ToolbarItemPlacement.automatic
            #endif

            ToolbarItem(placement: placement) {
                Button(action: {
                    Task {
                        try await job.stop()
                    }
                }) {
                    Image(systemName: "square.fill")
                }
                .disabled(job.state != .transcribing)
            }

            ToolbarItem(placement: placement) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "trash.fill")
                }
                .disabled(job.state.isBusy)
                .tint(.red)
            }

        }
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

#Preview {
    NavigationStack {
        FileJobView(job: HTFileJob(samples: []))
    }
}

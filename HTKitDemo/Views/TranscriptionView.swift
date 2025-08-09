//
//  TranscriptionView.swift
//  SwishDemo
//
//  Created by Ben Nortier on 2025/06/27.
//

import Combine
import SwiftUI
import HTKit


struct TranscriptionView: View {
    let transcription: HTObservableTranscription

    init(transcription: HTTranscription) {
        self.transcription = HTObservableTranscription(transcription: transcription)
    }

    var body: some View {
        VStack {
            Text(transcription.text.isEmpty ? "..." : transcription.text)
                .padding()
        }
    }
}

#Preview {
    TranscriptionView(transcription: HTTranscription())
}

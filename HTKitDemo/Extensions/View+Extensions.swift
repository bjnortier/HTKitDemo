//
//  View+Extensions.swift
//  SwishDemo
//
//  Created by Ben Nortier on 2025/06/27.
//
import SwiftUI

struct AlertError: LocalizedError {
    let _errorDescription: String?
    let _recoverySuggestion: String?

    var errorDescription: String? {
        _errorDescription
    }

    var recoverySuggestion: String? {
        _recoverySuggestion
    }

    init?(error: Error?) {
        if let localizedError = error as? LocalizedError {
            _errorDescription = localizedError.errorDescription
            _recoverySuggestion = localizedError.recoverySuggestion
        } else if let unlocalizedError = error {
            _errorDescription = unlocalizedError.localizedDescription
            _recoverySuggestion = "Unrecoverable"
        } else {
            return nil
        }
    }
}

extension View {
    func errorAlert(
        error: Binding<Error?>,
        buttonTitle: String = "OK",
        dismiss: (() -> Void)? = nil
    ) -> some View {
        if let error = error.wrappedValue {
            logger.error(error)
        }
        let alertError = AlertError(error: error.wrappedValue)
        return alert(
            isPresented: .constant(alertError != nil),
            error: alertError
        ) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
                if let dismiss {
                    dismiss()
                }
            }
        } message: { error in
            if let recoverySuggestion = error.recoverySuggestion {
                Text(recoverySuggestion)
            }
        }
    }
}

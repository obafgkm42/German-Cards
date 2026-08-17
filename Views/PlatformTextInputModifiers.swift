import SwiftUI
#if os(macOS)
import AppKit
#endif

extension View {
    @ViewBuilder
    func germanCardsAutocapitalization(_ mode: GermanCardsAutocapitalization) -> some View {
        #if os(iOS)
        switch mode {
        case .never:
            self.textInputAutocapitalization(.never)
        case .words:
            self.textInputAutocapitalization(.words)
        }
        #else
        self
        #endif
    }

    @ViewBuilder
    func germanCardsURLKeyboard() -> some View {
        #if os(iOS)
        self.keyboardType(.URL)
        #else
        self
        #endif
    }

    @ViewBuilder
    func germanCardsSearchSubmitLabel() -> some View {
        #if os(iOS)
        self.submitLabel(.search)
        #else
        self
        #endif
    }
}

enum GermanCardsAutocapitalization {
    case never
    case words
}

#if os(macOS)
struct MacSearchField: NSViewRepresentable {
    @Binding var text: String
    let prompt: String
    let onSubmit: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, onSubmit: onSubmit)
    }

    func makeNSView(context: Context) -> NSSearchField {
        let searchField = NSSearchField()
        searchField.placeholderString = prompt
        searchField.sendsWholeSearchString = true
        searchField.delegate = context.coordinator
        searchField.target = context.coordinator
        searchField.action = #selector(Coordinator.submit(_:))
        return searchField
    }

    func updateNSView(_ searchField: NSSearchField, context: Context) {
        context.coordinator.text = $text
        context.coordinator.onSubmit = onSubmit
        if searchField.stringValue != text {
            searchField.stringValue = text
        }
    }

    final class Coordinator: NSObject, NSSearchFieldDelegate {
        var text: Binding<String>
        var onSubmit: () -> Void

        init(text: Binding<String>, onSubmit: @escaping () -> Void) {
            self.text = text
            self.onSubmit = onSubmit
        }

        func controlTextDidChange(_ notification: Notification) {
            guard let searchField = notification.object as? NSSearchField else { return }
            text.wrappedValue = searchField.stringValue
        }

        @objc func submit(_ searchField: NSSearchField) {
            text.wrappedValue = searchField.stringValue
            onSubmit()
        }
    }
}
#endif

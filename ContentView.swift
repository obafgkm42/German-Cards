//
//  ContentView.swift
//  GermanCards
//
//  Created by lingji-yidong on 19/5/26.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: WordStore
    @AppStorage("app_appearance") private var appearanceRaw = AppAppearance.system.rawValue

    var body: some View {
        #if os(macOS)
        MacContentView(store: store)
            .tint(AppTheme.brand)
            .preferredColorScheme((AppAppearance(rawValue: appearanceRaw) ?? .system).colorScheme)
        #else
        TabView {
            HomeView()
                .tabItem {
                    Label("Grammar", systemImage: "text.book.closed")
                }

            SearchView(store: store)
                .tabItem {
                    Label("Cards", systemImage: "rectangle.stack")
                }

            SettingsView(store: store)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(AppTheme.brand)
        .preferredColorScheme((AppAppearance(rawValue: appearanceRaw) ?? .system).colorScheme)
        #endif
    }
}

#if os(macOS)
private enum MacMainSection: String, CaseIterable, Identifiable {
    case grammar
    case cards

    var id: String { rawValue }

    var title: String {
        switch self {
        case .grammar:
            return "Grammar"
        case .cards:
            return "Cards"
        }
    }

}

private struct MacContentView: View {
    @ObservedObject var store: WordStore
    @AppStorage("mac_main_section") private var selectedSectionRaw = MacMainSection.cards.rawValue

    private var selectedSection: Binding<MacMainSection> {
        Binding(
            get: { MacMainSection(rawValue: selectedSectionRaw) ?? .cards },
            set: { selectedSectionRaw = $0.rawValue }
        )
    }

    var body: some View {
        Group {
            switch selectedSection.wrappedValue {
            case .grammar:
                HomeView()
            case .cards:
                SearchView(store: store)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Section", selection: selectedSection) {
                    ForEach(MacMainSection.allCases) { section in
                        Text(section.title).tag(section)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .frame(width: 220)
            }
        }
    }
}
#endif

#if DEBUG
#Preview {
    ContentView(store: WordStore())
}
#endif

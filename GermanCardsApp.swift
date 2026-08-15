//
//  GermanCardsApp.swift
//  GermanCards
//
//  Created by lingji-yidong on 19/5/26.
//

import SwiftUI

@main
struct GermanCardsApp: App {
    @StateObject private var store = WordStore()

    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppIconAppearanceController.self) private var appIconController
    #endif

    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView(store: store)
        }
        .defaultSize(width: 680, height: 820)
        .windowToolbarStyle(.unified(showsTitle: false))

        Settings {
            SettingsView(store: store)
        }
        .defaultSize(width: 560, height: 680)
        .windowResizability(.contentSize)
        #else
        WindowGroup {
            ContentView(store: store)
        }
        #endif
    }
}

//
//  ContentView.swift
//  Klepsidra
//

import SwiftUI
import LiveViewNative

struct ContentView: View {
    var body: some View {
        LiveView(.automatic(
            development: .localhost(path: "/"),
            production: .custom(URL(string: "https://klepsidra.io/")!)
        ))
    }
}

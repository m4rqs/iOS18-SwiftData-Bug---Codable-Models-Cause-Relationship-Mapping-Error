//
//  iOS18SwiftDataIssueApp.swift
//  iOS18SwiftDataIssue
//
//  Created by Marek Sienczak on 20/09/2024.
//

import SwiftUI
import SwiftData

@main
struct iOS18SwiftDataIssueApp: App {
    @State private var modelContainer = SharedDataModel.shared.modelContainer

    var body: some Scene {
        WindowGroup {
            NotesView()
        }
        .modelContainer(modelContainer)
    }
}

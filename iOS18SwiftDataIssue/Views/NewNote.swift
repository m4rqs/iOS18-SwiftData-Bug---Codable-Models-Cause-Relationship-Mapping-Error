//
//  NewNote.swift
//  Example
//
//  Created by Marek Sienczak on 30/08/2024.
//

import SwiftUI

@MainActor
struct NewNote: View
{
    @Environment(\.dismiss) private var dismiss

    var notesViewModel: NotesViewModel
    @State private var heading: String = ""
    @State private var tags: String = ""

    var body: some View {
        Form {
            Section("Heading") {
                TextField("Heading", text: $heading)
            }
            Section("Tags") {
                TextField("Tags", text: $tags, axis: .vertical)
            }
        }
        .navigationTitle("New note")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    notesViewModel.addNote(heading: heading, tags: tags)
                    dismiss()
                } label: {
                    Text("Add")
                }
            }
        }
    }

    init (notesViewModel: NotesViewModel) {
        self.notesViewModel = notesViewModel
    }
}

//
//  EditNoteView.swift
//  Example
//
//  Created by Marek Sienczak on 30/08/2024.
//

import SwiftUI

@MainActor
struct EditNoteView: View
{
    @Environment(\.dismiss) private var dismiss

    private var note: Note

    @Bindable var notesViewModel: NotesViewModel
    @State private var heading: String
    @State private var tags: String

    var body: some View {
        Form {
            Section("Heading") {
                TextField("Heading", text: $heading)
            }
            Section("Tags") {
                TextField("Tags", text: $tags)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Note view")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    notesViewModel.updateNote(note: note, heading: heading, tags: tags)
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }

    init (note: Note, notesViewModel: NotesViewModel) {
        self.note = note
        _heading = State(initialValue: note.heading)
        _tags = State(initialValue: note.tags?.map{$0.name}.sorted().joined(separator: " ") ?? "")
        _notesViewModel = Bindable(notesViewModel)
    }
}

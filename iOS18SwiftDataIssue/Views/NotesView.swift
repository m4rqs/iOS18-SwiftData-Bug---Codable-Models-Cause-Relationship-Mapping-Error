//
//  ContentView.swift
//  Example
//
//  Created by Marek Sienczak on 24/08/2024.
//

import SwiftUI
import SwiftData

@MainActor
struct NotesView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.colorScheme) private var colorScheme

    @State private var notesViewModel = NotesViewModel()
    @State private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            NoteListView(notesViewModel: notesViewModel)
                .navigationTitle("Notes")
                .searchable(text: $notesViewModel.searchText)
                .navigationDestination(for: Routes.self) { route in
                    switch route {
                        case .addNote:
                            NewNote(notesViewModel: notesViewModel)
                        case .viewNote(let note):
                            let note = notesViewModel.fetchedNotes.first(where: {$0.uuid == note.uuid})!
                            NoteView(note: note, notesViewModel: notesViewModel, path: $router.path)
                        case .editNote(let note):
                            EditNoteView(note: note, notesViewModel: notesViewModel)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            addNewNote()
                        } label: {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
        }
    }

    func addNewNote() {
        router.path.append(Routes.addNote)
    }
}

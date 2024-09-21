//
//  ContentView.swift
//  iOS18SwiftDataIssue
//
//  Created by Marek Sienczak on 20/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(notes) { note in
                    NavigationLink {
                        Text(note.heading)
                    } label: {
                        Text(note.heading)
                    }
                }
                .onDelete(perform: deleteNotes)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addNote) {
                        Label("Add Note", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addNote() {
        withAnimation {
            let newNote = Note(heading: "New Note")
            modelContext.insert(newNote)
        }
    }

    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}

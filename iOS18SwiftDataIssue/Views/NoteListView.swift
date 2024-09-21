//
//  NoteListView.swift
//  Example
//
//  Created by Marek Sienczak on 30/08/2024.
//

import SwiftUI
import SwiftData

@MainActor
struct NoteListView: View
{
    @Bindable var notesViewModel: NotesViewModel
    @Query private var notes: [Note]

    var body: some View {
        List(notesViewModel.searchResults, id: \.uuid, selection: $notesViewModel.selectedNotes) { note in
            NavigationLink(value: Routes.viewNote(note)) {
                HStack {
                    Text(note.heading)
                    Spacer()
                    VStack {
                        Text("Tags (" + String(note.tags?.count ?? 0) + ")")
                            .font(.footnote)
                            .foregroundStyle(Color.secondary)
                        Spacer()
                    }
                    .padding(5)
                }
            }
        }
        .onAppear {
            notesViewModel.fetchedNotes = notes
        }
    }

    init(notesViewModel: NotesViewModel)
    {
        _notesViewModel = Bindable(notesViewModel)
//        let searchText = self.notesViewModel.searchText
//        let predicate = #Predicate<Note> { note in
//            (searchText.isEmpty ? true : note.heading.localizedStandardContains(searchText)) ||
//            (note.tags.flatMap {
//                $0.contains { $0.name.localizedStandardContains(searchText) }
//            } == true)
//        }
//        let descriptor = FetchDescriptor<Note>(predicate: predicate)
//        _notes = Query(descriptor)
    }
}

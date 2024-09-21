//
//  NoteView.swift
//  Example
//
//  Created by Marek Sienczak on 30/08/2024.
//

import SwiftUI

@MainActor
struct NoteView: View
{
    var notesViewModel: NotesViewModel
    @Binding var path: NavigationPath
    private var note: Note

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(note.heading)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.accentColor)
                Spacer()
            }
            .padding(.bottom, 10)
            Text((note.tags?.map{"#" + $0.name}.sorted().joined(separator: ", ") ?? ""))
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Note view")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    path.removeLast(path.count)
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .fontWeight(.semibold)
                        Text("Notes")
                            .padding(.leading, -3)
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    path.append(Routes.editNote(note))
                } label: {
                    Text("Edit")
                }
            }
        }
    }

    init (note: Note, notesViewModel: NotesViewModel, path: Binding<NavigationPath>) {
        self.note = note
        self.notesViewModel = notesViewModel
        _path = path
    }
}

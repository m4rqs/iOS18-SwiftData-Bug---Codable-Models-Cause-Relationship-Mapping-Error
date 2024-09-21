//
//  NotesViewModel.swift
//  Example
//
//  Created by Marek Sienczak on 30/08/2024.
//

import Foundation
import SwiftData

@MainActor
@Observable
final class NotesViewModel {
    @ObservationIgnored
    private let dataSource: DataSource
    var searchText = ""
    var selectedNotes = Set<String>()
    var fetchedNotes: [Note] = []

    // this is not effective but I do not know how to build a query with optional property
    var searchResults: [Note] {
        return fetchedNotes.filter { note in
            if searchText.isEmpty {
                return true
            } else {
                if note.heading.localizedCaseInsensitiveContains(searchText) {
                    return true
                }
                if let tags = note.tags, tags.contains(where: {$0.name.localizedStandardContains(searchText)}) {
                    return true
                }
                return false
            }
        }
    }

    init(dataSource: DataSource = DataSource.shared) {
        self.dataSource = dataSource
    }

    func addNote(heading: String, tags: String) {
        dataSource.addNote(heading: heading, tags: tags)
    }

    func updateNote(note: Note, heading: String, tags: String) {
        dataSource.updateNote(note: note, heading: heading, tags: tags)
    }
}

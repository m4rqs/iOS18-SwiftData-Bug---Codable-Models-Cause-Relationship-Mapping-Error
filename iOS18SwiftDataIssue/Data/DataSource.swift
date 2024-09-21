//
//  NoteDataSource.swift
//  Example
//
//  Created by Marek Sienczak on 12/09/2024.
//

import Foundation
import SwiftData

final class DataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = DataSource()

    @MainActor
    private init() {
        self.modelContainer = SharedDataModel.shared.modelContainer
        self.modelContext = modelContainer.mainContext
    }

    public func addNote(heading: String, tags: String) {
        let note = Note(heading: heading)
        modelContext.insert(note)
        let tagNames = tags.split(separator: " ").map{$0.trimmingCharacters(in: .whitespacesAndNewlines)}
        updateTags(note: note, tagNames: tagNames)
        try? modelContext.save()
    }

    func fetchNotes() -> [Note] {
        do {
            return try modelContext.fetch(FetchDescriptor<Note>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func updateNote(note: Note, heading: String, tags: String) {
        note.heading = heading
        let tagNames = tags.split(separator: " ").map{$0.trimmingCharacters(in: .whitespacesAndNewlines)}
        updateTags(note: note, tagNames: tagNames)
        try? self.modelContext.save()
    }

    private func removeTags(note: Note, tagNames: [String]) {
        if let tags = note.tags {
            var indexSet = IndexSet()
            for i in 0..<tags.count {
                if !tagNames.contains(where: {$0 == tags[i].name}) {
                    indexSet.insert(i)
                }
            }
            note.tags!.remove(atOffsets: indexSet)
        }
    }

    private func fetchTag(_ name: String) -> Tag? {
        do {
            let predicate = #Predicate<Tag> { $0.name == name }
            var descriptor = FetchDescriptor(predicate: predicate)
            descriptor.fetchLimit = 1
            let tags = try self.modelContext.fetch(descriptor)
            return tags.first;
        } catch {
            return nil
        }
    }

    private func addTags(note: Note, tagNames: [String]) {
        if note.tags == nil {
            note.tags = []
        }
        for tagName in tagNames {
            if let tag = fetchTag(tagName) {
                if !note.tags!.contains(where: {$0.name == tagName}) {
                    note.tags!.append(tag)
                }
            } else {
                // The following line throws the exception on iOS18 when Tag conforms to Codable:
                // Illegal attempt to map a relationship containing temporary objects to its identifiers.
                note.tags!.append(Tag(tagName))
            }
        }
    }

    private func addTagsWorkaround(note: Note, tagNames: [String]) {
        if note.tags == nil {
            note.tags = []
        }
        for tagName in tagNames {
            if let tag = fetchTag(tagName) {
                if !note.tags!.contains(where: {$0.name == tagName}) {
                    note.tags!.append(tag)
                }
            } else {
                // Workaround
                modelContext.insert(Tag(tagName))
                try? modelContext.save() // without save does not work
                if let newTag = fetchTag(tagName) {
                    note.tags!.append(newTag)
                }
            }
        }
    }

    private func updateTags(note: Note, tagNames: [String]) {
        removeTags(note: note, tagNames: tagNames)
        addTags(note: note, tagNames: tagNames)
        //addTagsWorkaround(note: note, tagNames: tagNames)
    }
}

//
//  Logger.swift
//  Langpad
//
//  Created by Marek Sienczak on 25/03/2024.
//

import Foundation
import OSLog

extension Logger : @unchecked Sendable {
    private static let subsystem = Bundle.main.bundleIdentifier!
    static let langpadApp = Logger(subsystem: subsystem, category: "LangpadApp")
    static let sharedDataModel = Logger(subsystem: subsystem, category: "SharedDataModel")
    static let dataModel = Logger(subsystem: subsystem, category: "DataModel")
    static let note = Logger(subsystem: subsystem, category: "Note")
    static let language = Logger(subsystem: subsystem, category: "Language")
    static let tag = Logger(subsystem: subsystem, category: "Tag")
    static let textDocument = Logger(subsystem: subsystem, category: "TextDocument")
    static let notificationService = Logger(subsystem: subsystem, category: "NotificationService")
    static let notesView = Logger(subsystem: subsystem, category: "NotesView")
    static let dataView = Logger(subsystem: subsystem, category: "DataView")
    static let dataContext = Logger(subsystem: subsystem, category: "DataContext")
    static let sharedDataSource = Logger(subsystem: subsystem, category: "SharedDataSource")

    func catchError(_ error: Error) {
        self.fault("\(error.localizedDescription)")
    }
}

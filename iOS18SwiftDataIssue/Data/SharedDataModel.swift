//
//  SharedDataModel.swift
//  Example
//
//  Created by Marek Sienczak on 30/08/2024.
//

import Foundation
import SwiftData

struct SharedDataModel : Sendable
{
    public static let shared: SharedDataModel = .init()

    public let modelContainer: ModelContainer

    private init() {
        self.modelContainer = SharedDataModel.createModelContainer()
    }

    private static func createModelContainer() -> ModelContainer {
        let schema = Schema([Note.self /* your other unrelated models here */])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration])
        } catch {
            fatalError()
        }
    }
}

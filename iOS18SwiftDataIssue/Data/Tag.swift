//
//  Tag.swift
//  iOS18SwiftDataIssue
//
//  Created by Marek Sienczak on 20/09/2024.
//

import Foundation
import SwiftData

@Model
final public class Tag: Identifiable, Codable
{
    enum CodingKeys: CodingKey {
        case name
    }

    var name: String = ""
    @Relationship(deleteRule: .nullify, inverse: \Note.tags) var notes: [Note]?

    init(_ name: String) {
        self.name = name
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
 }

//
//  Note.swift
//  iOS18SwiftDataIssue
//
//  Created by Marek Sienczak on 20/09/2024.
//

import Foundation
import SwiftData

@Model
final public class Note: Identifiable, Codable, Hashable
{
    enum CodingKeys: CodingKey {
        case heading
        case tags
    }

    public private(set) var uuid = UUID().uuidString

    var heading: String = ""
    var tags: [Tag]?

    @Transient var tagNames: [String]?

    init(heading: String = "") {
        self.heading = heading
    }

    required public init(from decoder: Decoder) throws {
        self.uuid = UUID().uuidString
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let heading = try container.decode(String.self, forKey: .heading)
        self.heading = heading
        let tagNames = (try? container.decodeIfPresent(String.self, forKey: .tags)) ?? heading
        self.tagNames = tagNames.components(separatedBy: " ")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(heading, forKey: .heading)
        let tags = self.tags?.map{$0.name}.joined(separator: " ")
        if tags != self.heading {
            try container.encodeIfPresent(tags, forKey: .tags)
        }
    }
}

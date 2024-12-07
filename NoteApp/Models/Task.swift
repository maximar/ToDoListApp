//
//  Task.swift
//
//  Created by Maximar Yepez on 12/4/24.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, content: String, isComplete: Bool = false ) {
        self.id = id
        self.title = title
        self.content = content
        self.isCompleted = false
    }
}


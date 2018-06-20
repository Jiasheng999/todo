//
//  Todo.swift
//  Todo
//
//  Created by Tang Jiasheng on 2018/6/19.
//  Copyright © 2018 Jiasheng Tang. All rights reserved.
//

import Foundation
import UIKit

struct Todo: Codable {
    var completion: Int
    var content: String
    var tags: [String]
    var due: Date
//    var color: UIColor
    var completionTime: Date?
    
    static func loadSampleData() -> [Todo] {
        return [
            Todo(completion: 0, content: "Water plants", tags: ["lifestyle", "fun"], due: Date(), completionTime: nil),
            Todo(completion: 0, content: "Run", tags: ["sports", "lifestyle"], due: Date(), completionTime: nil),
            Todo(completion: 0, content: "Buy food", tags: [], due: Date(), completionTime: nil)]
    }
    
    static func getArchiveURL() -> URL {
        let plistName = "todo"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }
    
    static func saveToFile(todos: [Todo]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedTodos = try? propertyListEncoder.encode(todos)
        try? encodedTodos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Todo]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedTodosData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedTodos = try? propertyListDecoder.decode(Array<Todo>.self, from: retrievedTodosData) else { return nil }
        return decodedTodos
    }
}

//
//  ToDo.swift
//  ToDoList
//
//  Created by Андрей Фокин on 19.10.21.
//

import Foundation

struct ToDo: Equatable, Codable{
    var id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadTodos() -> [ToDo]? {
        guard let decodeToDos = try? Data(contentsOf: url) else {return nil}
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<ToDo>.self, from: decodeToDos )
        
    }
    
    static func saveTodos(_ todos: [ToDo]){
        let encoder = PropertyListEncoder()
        let encodeToDos = try? encoder.encode(todos)
        try? encodeToDos?.write(to: url, options: .noFileProtection)
        
    }
    
    
    static func loadSampleToDos () -> [ToDo]{
        let toDo1 = ToDo(title: "ToDo1", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let toDo2 = ToDo(title: "ToDo2", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let toDo3 = ToDo(title: "ToDo3", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [toDo1, toDo2, toDo3]
    }
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    static let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let url = directory.appendingPathComponent("todos").appendingPathExtension("plist")
}

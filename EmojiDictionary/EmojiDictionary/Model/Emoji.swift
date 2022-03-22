//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Андрей Фокин on 29.09.21.
//

import Foundation


struct Emoji: Codable {
    
    let symbol: String
    let name: String
    let description: String
    let usage: String
    
    static let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Data_save").appendingPathExtension("plist")
    
    static func saveToFile(emojis: [Emoji]){
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(emojis)
        try? encodedData?.write(to: fileURL, options: .noFileProtection)
        
    }
    
    static func loadFromFile()-> [Emoji] {
        
        let propertyListDecoder = PropertyListDecoder()
        guard let retrivedDate = try? Data(contentsOf: fileURL),
              let decodedData = try? propertyListDecoder.decode(Array<Emoji>.self, from: retrivedDate) else {return Emoji.samleEmojis()}
        return decodedData
    }
    
    static func samleEmojis() -> [Emoji] {
        
        return [Emoji(symbol: "⚽️", name: "Ball", description: "Stuff for football", usage: "Sport"),
                Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage:"happiness"),
                Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsurewhat to think; displeasure"),
                Emoji(symbol: "😍", name: "Heart Eyes",description: "A smiley face with hearts for eyes.",usage: "love of something; attractive"),
                Emoji(symbol: "🧑‍💻", name: "Developer",description: "A person working on a MacBook (probably using Xcodeto write iOS apps in Swift).", usage: "apps, software,programming"),
                Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "something slow"),
                Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
                Emoji(symbol: "🍝", name: "Spaghetti",description: "A plate of spaghetti.", usage: "spaghetti"),
                Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
                Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
                Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
                Emoji(symbol: "💔", name: "Broken Heart",description: "A red, broken heart.", usage: "extreme sadness"), Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
                Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")

]
    }
    
}







//
//  ClientInfo.swift
//  HotelManzana
//
//  Created by Андрей Фокин on 12.10.21.
//

import Foundation

struct Person {
    var firstName: String
    var lastName: String
    var checkInDate: Date
    var chekOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var wifi: Bool
    var roomType: RoomType
}

struct RoomType: Equatable {
    
    var id: Int
        var name: String
        var shortName: String
        var price: Int
    
    static func == (rhs: RoomType, lhs: RoomType) -> Bool {
        return rhs.id == lhs.id
    }
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens",
                   shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King",
                   shortName: "K", price: 209),
                RoomType(id: 2, name: "Penthouse Suite",
                    shortName: "PHS", price: 309)]
    }
    
}

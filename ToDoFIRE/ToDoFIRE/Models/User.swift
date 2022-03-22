//
//  User.swift
//  ToDoFIRE
//
//  Created by Андрей Фокин on 27.09.21.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String!
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
    }
}

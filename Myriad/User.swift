//
//  User.swift
//  Myriad
//
//  Created by Anthony Smith on 3/26/15.
//  Copyright (c) 2015 Anthony Smith. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var name: String
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, newEmail: String, newName: String) -> User {
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: moc) as User
        newUser.email = newEmail
        newUser.name = newName
        
        return newUser
    }


}

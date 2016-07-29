//
//  User+CoreDataProperties.swift
//  swift24
//
//  Created by huangjian on 16/6/23.
//  Copyright © 2016年 jollycorp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var id: NSNumber?
    @NSManaged var username: String?
    @NSManaged var password: String?

}

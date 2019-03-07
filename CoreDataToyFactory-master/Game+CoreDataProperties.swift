//
//  Game+CoreDataProperties.swift
//  CoreDataSuperExample
//
//  Created by MAC Consultant on 3/6/19.
//  Copyright © 2019 Kevin Yu. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var genre: String?
    @NSManaged public var name: String?
    @NSManaged public var console: String?

}

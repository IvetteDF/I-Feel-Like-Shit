//
//  Question+CoreDataProperties.swift
//  I Feel Like Shit
//
//  Created by Ivette Fernandez on 2/22/22.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var defaultQuestion: Bool

}

extension Question : Identifiable {

}

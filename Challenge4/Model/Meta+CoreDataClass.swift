//
//  Meta+CoreDataClass.swift
//  Challenge4
//
//  Created by STELLA CAVALCANTE ARANTES HADA on 31/01/25.
//
//

import Foundation
import CoreData

@objc(Meta)
public class Meta: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meta> {
        return NSFetchRequest<Meta>(entityName: "Meta")
    }

    @NSManaged public var numeroMeta: Int16

}

extension Meta : Identifiable {

}


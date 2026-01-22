//
//  CustomTag.swift
//  beautycase
//
//  自定义标签数据模型
//

import Foundation
import CoreData

extension CustomTag {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomTag> {
        return NSFetchRequest<CustomTag>(entityName: "CustomTag")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var type: String // "from", "who", "category"
    @NSManaged public var createdAt: Date
}

extension CustomTag : Identifiable {
    
}


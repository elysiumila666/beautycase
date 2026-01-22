//
//  CyberloafingItem.swift
//  beautycase
//
//  浏览记录项数据模型
//

import Foundation
import CoreData

extension CyberloafingItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CyberloafingItem> {
        return NSFetchRequest<CyberloafingItem>(entityName: "CyberloafingItem")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var url: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var fileType: String
    @NSManaged public var title: String
    @NSManaged public var thumbnailImage: Data?
    @NSManaged public var fromTag: String?
    @NSManaged public var whoTag: String?
    @NSManaged public var categoryTag: String?
    @NSManaged public var createdAt: Date
    @NSManaged public var dailyRecord: DailyRecord?
}

extension CyberloafingItem : Identifiable {
    
}


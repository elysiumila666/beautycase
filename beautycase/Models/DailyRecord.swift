//
//  DailyRecord.swift
//  beautycase
//
//  每日记录数据模型
//

import Foundation
import CoreData

extension DailyRecord {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyRecord> {
        return NSFetchRequest<DailyRecord>(entityName: "DailyRecord")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var createdAt: Date
    @NSManaged public var cyberloafingItems: NSSet?
    @NSManaged public var dailyCareer: DailyCareer?
    
    public var cyberloafingItemsArray: [CyberloafingItem] {
        let set = cyberloafingItems as? Set<CyberloafingItem> ?? []
        return set.sorted { $0.createdAt > $1.createdAt }
    }
}

extension DailyRecord : Identifiable {
    
}


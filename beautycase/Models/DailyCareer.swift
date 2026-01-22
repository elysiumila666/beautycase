//
//  DailyCareer.swift
//  beautycase
//
//  日程记录数据模型
//

import Foundation
import CoreData

extension DailyCareer {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyCareer> {
        return NSFetchRequest<DailyCareer>(entityName: "DailyCareer")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var threeFrogsData: Data? // 存储为JSON数据
    @NSManaged public var morningActivity: String?
    
    public var threeFrogs: [String] {
        get {
            guard let data = threeFrogsData,
                  let array = try? JSONDecoder().decode([String].self, from: data) else {
                return ["", "", ""]
            }
            return array.count == 3 ? array : ["", "", ""]
        }
        set {
            threeFrogsData = try? JSONEncoder().encode(newValue.count == 3 ? newValue : ["", "", ""])
        }
    }
    @NSManaged public var afternoonActivity: String?
    @NSManaged public var eveningActivity: String?
    @NSManaged public var reflectionType: String
    @NSManaged public var reflectionContent: String?
    @NSManaged public var createdAt: Date
    @NSManaged public var dailyRecord: DailyRecord?
}

extension DailyCareer : Identifiable {
    
}


//
//  PersistenceController.swift
//  beautycase
//
//  Core Data持久化控制器
//

import CoreData
import Foundation

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DataModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed to load: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // 获取或创建当天的DailyRecord
    func getOrCreateDailyRecord(for date: Date) -> DailyRecord {
        let context = container.viewContext
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        
        let request: NSFetchRequest<DailyRecord> = DailyRecord.fetchRequest()
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", 
                                       startOfDay as NSDate,
                                       calendar.date(byAdding: .day, value: 1, to: startOfDay)! as NSDate)
        
        if let existingRecord = try? context.fetch(request).first {
            return existingRecord
        }
        
        let newRecord = DailyRecord(context: context)
        newRecord.id = UUID()
        newRecord.date = startOfDay
        newRecord.createdAt = Date()
        
        save()
        return newRecord
    }
    
    // 获取指定日期的CyberloafingItems
    func getCyberloafingItems(for date: Date) -> [CyberloafingItem] {
        let dailyRecord = getOrCreateDailyRecord(for: date)
        return dailyRecord.cyberloafingItemsArray
    }
    
    // 获取指定日期的DailyCareer
    func getDailyCareer(for date: Date) -> DailyCareer? {
        let dailyRecord = getOrCreateDailyRecord(for: date)
        return dailyRecord.dailyCareer
    }
    
    // 获取或创建DailyCareer
    func getOrCreateDailyCareer(for date: Date) -> DailyCareer {
        let dailyRecord = getOrCreateDailyRecord(for: date)
        
        if let existing = dailyRecord.dailyCareer {
            return existing
        }
        
        let newCareer = DailyCareer(context: container.viewContext)
        newCareer.id = UUID()
        newCareer.threeFrogs = ["", "", ""] // 这会调用setter
        newCareer.reflectionType = "diary"
        newCareer.createdAt = Date()
        newCareer.dailyRecord = dailyRecord
        
        dailyRecord.dailyCareer = newCareer
        save()
        
        return newCareer
    }
    
    // 获取自定义标签
    func getCustomTags(type: String) -> [CustomTag] {
        let request: NSFetchRequest<CustomTag> = CustomTag.fetchRequest()
        request.predicate = NSPredicate(format: "type == %@", type)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CustomTag.createdAt, ascending: false)]
        
        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    // 创建自定义标签
    func createCustomTag(name: String, type: String) -> CustomTag {
        let context = container.viewContext
        let tag = CustomTag(context: context)
        tag.id = UUID()
        tag.name = name
        tag.type = type
        tag.createdAt = Date()
        
        save()
        return tag
    }
    
    // 删除自定义标签
    func deleteCustomTag(_ tag: CustomTag) {
        let context = container.viewContext
        
        // 清除使用该标签的所有items的对应标签
        let fromRequest: NSFetchRequest<CyberloafingItem> = CyberloafingItem.fetchRequest()
        if tag.type == "from" {
            fromRequest.predicate = NSPredicate(format: "fromTag == %@", tag.name)
            if let items = try? context.fetch(fromRequest) {
                items.forEach { $0.fromTag = nil }
            }
        } else if tag.type == "who" {
            fromRequest.predicate = NSPredicate(format: "whoTag == %@", tag.name)
            if let items = try? context.fetch(fromRequest) {
                items.forEach { $0.whoTag = nil }
            }
        } else if tag.type == "category" {
            fromRequest.predicate = NSPredicate(format: "categoryTag == %@", tag.name)
            if let items = try? context.fetch(fromRequest) {
                items.forEach { $0.categoryTag = nil }
            }
        }
        
        context.delete(tag)
        save()
    }
}


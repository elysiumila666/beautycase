//
//  DailyCareerView.swift
//  beautycase
//
//  Daily Career页面视图
//

import SwiftUI
import CoreData

struct DailyCareerView: View {
    @Binding var selectedDate: Date
    @State private var dailyCareer: DailyCareer? = nil
    @State private var threeFrogs: [String] = ["", "", ""]
    @State private var reflectionType: String = "diary"
    @State private var reflectionContent: String = ""
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter
    }
    
    var body: some View {
        ZStack {
            // 页面背景 - 白色，圆角
            Color.white
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // 标题区域
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Daily Career")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text(dateFormatter.string(from: selectedDate))
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
                    // Three Frogs部分
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Three Frogs")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 12) {
                            ForEach(0..<3, id: \.self) { index in
                                HStack(spacing: 8) {
                                    Text("\(index + 1).")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.gray)
                                        .frame(width: 24)
                                    
                                    TextField("Priority task...", text: Binding(
                                        get: { threeFrogs[safe: index] ?? "" },
                                        set: { newValue in
                                            if index < threeFrogs.count {
                                                threeFrogs[index] = newValue
                                                saveThreeFrogs()
                                            }
                                        }
                                    ))
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .font(.system(size: 16))
                                    .padding(12)
                                    .background(Color.gray.opacity(0.05))
                                    .cornerRadius(12)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Time Blocks部分
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Time Blocks")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 4, height: 4)
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 4, height: 4)
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 4, height: 4)
                            }
                        }
                        
                        TimeBlocksSlider(
                            morningActivity: Binding(
                                get: { dailyCareer?.morningActivity ?? "" },
                                set: { newValue in
                                    updateDailyCareer { career in
                                        career.morningActivity = newValue.isEmpty ? nil : newValue
                                    }
                                }
                            ),
                            afternoonActivity: Binding(
                                get: { dailyCareer?.afternoonActivity ?? "" },
                                set: { newValue in
                                    updateDailyCareer { career in
                                        career.afternoonActivity = newValue.isEmpty ? nil : newValue
                                    }
                                }
                            ),
                            eveningActivity: Binding(
                                get: { dailyCareer?.eveningActivity ?? "" },
                                set: { newValue in
                                    updateDailyCareer { career in
                                        career.eveningActivity = newValue.isEmpty ? nil : newValue
                                    }
                                }
                            )
                        )
                    }
                    .padding(.horizontal, 24)
                    
                    // Today's Reflection部分
                    VStack(alignment: .leading, spacing: 12) {
                        ReflectionTabView(
                            selectedType: $reflectionType,
                            content: $reflectionContent
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
            }
        }
        .onAppear {
            loadDailyCareer()
        }
        .onChange(of: selectedDate) { _ in
            loadDailyCareer()
        }
    }
    
    private func loadDailyCareer() {
        let persistenceController = PersistenceController.shared
        let career = persistenceController.getOrCreateDailyCareer(for: selectedDate)
        dailyCareer = career
        
        // 加载Three Frogs
        threeFrogs = career.threeFrogs
        
        // 加载Reflection
        reflectionType = career.reflectionType
        reflectionContent = career.reflectionContent ?? ""
    }
    
    private func saveThreeFrogs() {
        updateDailyCareer { career in
            career.threeFrogs = threeFrogs
        }
    }
    
    private func updateDailyCareer(_ update: (DailyCareer) -> Void) {
        let persistenceController = PersistenceController.shared
        let career = persistenceController.getOrCreateDailyCareer(for: selectedDate)
        update(career)
        career.reflectionType = reflectionType
        career.reflectionContent = reflectionContent.isEmpty ? nil : reflectionContent
        persistenceController.save()
        dailyCareer = career
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct DailyCareerView_Previews: PreviewProvider {
    static var previews: some View {
        DailyCareerView(selectedDate: .constant(Date()))
    }
}


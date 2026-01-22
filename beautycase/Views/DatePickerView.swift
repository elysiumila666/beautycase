//
//  DatePickerView.swift
//  beautycase
//
//  横向日期选择器
//

import SwiftUI

struct DatePickerView: View {
    @Binding var selectedDate: Date
    @State private var dates: [Date] = []
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(dates, id: \.self) { date in
                    DateButton(
                        date: date,
                        isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate)
                    ) {
                        selectedDate = date
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            generateDates()
        }
    }
    
    private func generateDates() {
        let calendar = Calendar.current
        let today = Date()
        
        // 生成过去30天到未来7天的日期
        var dateList: [Date] = []
        for i in -30...7 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                dateList.append(date)
            }
        }
        
        dates = dateList
    }
}

struct DateButton: View {
    let date: Date
    let isSelected: Bool
    let action: () -> Void
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    private var weekdayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(weekdayFormatter.string(from: date))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(isSelected ? .white : .gray)
                
                Text(dayFormatter.string(from: date))
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(isSelected ? .white : .black)
            }
            .frame(width: 50, height: 60)
            .background(isSelected ? Color.black : Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(isSelected ? 0.2 : 0.05), radius: 4, x: 0, y: 2)
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(selectedDate: .constant(Date()))
    }
}


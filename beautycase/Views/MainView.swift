//
//  MainView.swift
//  beautycase
//
//  主视图 - 包含日期选择器和页面容器
//

import SwiftUI

struct MainView: View {
    @State private var selectedDate = Date()
    @State private var selectedPage = 0
    
    var body: some View {
        ZStack {
            // 浅色背景
            Color(hex: "F5F5F5")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 顶部日期选择器
                DatePickerView(selectedDate: $selectedDate)
                    .padding(.top, 10)
                
                // 页面容器 - 左右滑动
                TabView(selection: $selectedPage) {
                    CyberloafingView(selectedDate: $selectedDate)
                        .tag(0)
                    
                    DailyCareerView(selectedDate: $selectedDate)
                        .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                // 页面指示器
                HStack(spacing: 8) {
                    ForEach(0..<2) { index in
                        Circle()
                            .fill(index == selectedPage ? Color.black : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .preferredColorScheme(.light)
    }
}

// 扩展Color以支持十六进制颜色
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


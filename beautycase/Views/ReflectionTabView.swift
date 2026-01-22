//
//  ReflectionTabView.swift
//  beautycase
//
//  今日感受Tab切换视图
//

import SwiftUI

struct ReflectionTabView: View {
    @Binding var selectedType: String
    @Binding var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today's Reflection")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            // Tab按钮
            HStack(spacing: 8) {
                ReflectionTabButton(
                    icon: "sparkles",
                    title: "Gratitude",
                    isSelected: selectedType == "gratitude",
                    action: { selectedType = "gratitude" }
                )
                
                ReflectionTabButton(
                    icon: "lightbulb.fill",
                    title: "Inspiration",
                    isSelected: selectedType == "inspiration",
                    action: { selectedType = "inspiration" }
                )
                
                ReflectionTabButton(
                    icon: "pencil",
                    title: "Diary",
                    isSelected: selectedType == "diary",
                    action: { selectedType = "diary" }
                )
            }
            
            // 内容输入区域
            ZStack(alignment: .topLeading) {
                if content.isEmpty {
                    Text(getPlaceholder())
                        .font(.system(size: 14))
                        .foregroundColor(.gray.opacity(0.6))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                }
                
                TextEditor(text: $content)
                    .font(.system(size: 14))
                    .frame(minHeight: 150)
                    .scrollContentBackground(.hidden)
                    .padding(4)
            }
            .background(Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
    }
    
    private func getPlaceholder() -> String {
        switch selectedType {
        case "gratitude":
            return "What are you grateful for today?"
        case "inspiration":
            return "What inspired you today?"
        case "diary":
            return "How was your day?"
        default:
            return "Write your reflection..."
        }
    }
}

struct ReflectionTabButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                Text(title)
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(isSelected ? .white : .black)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.black : Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

struct ReflectionTabView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionTabView(
            selectedType: .constant("diary"),
            content: .constant("")
        )
        .padding()
    }
}


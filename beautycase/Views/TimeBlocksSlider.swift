//
//  TimeBlocksSlider.swift
//  beautycase
//
//  可滑动的Time Blocks视图
//

import SwiftUI

struct TimeBlocksSlider: View {
    @Binding var morningActivity: String
    @Binding var afternoonActivity: String
    @Binding var eveningActivity: String
    
    @State private var currentIndex = 0
    
    private let timeBlocks = ["Morning", "Afternoon", "Evening"]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 背景卡片
                HStack(spacing: 0) {
                    ForEach(0..<3, id: \.self) { index in
                        TimeBlockCard(
                            title: timeBlocks[index],
                            content: getContent(for: index),
                            placeholder: getPlaceholder(for: index),
                            onContentChange: { newContent in
                                setContent(for: index, content: newContent)
                            }
                        )
                        .frame(width: geometry.size.width * 0.85)
                        .padding(.trailing, index < 2 ? 12 : 0)
                    }
                }
                .offset(x: -CGFloat(currentIndex) * geometry.size.width * 0.85)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: currentIndex)
                
                // 指示器
                HStack(spacing: 6) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex ? Color.black : Color.gray.opacity(0.3))
                            .frame(width: 6, height: 6)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .offset(y: geometry.size.height - 20)
            }
        }
        .frame(height: 200)
        .gesture(
            DragGesture()
                .onEnded { value in
                    let threshold: CGFloat = 50
                    if value.translation.width > threshold && currentIndex > 0 {
                        currentIndex -= 1
                    } else if value.translation.width < -threshold && currentIndex < 2 {
                        currentIndex += 1
                    }
                }
        )
    }
    
    private func getContent(for index: Int) -> Binding<String> {
        switch index {
        case 0:
            return $morningActivity
        case 1:
            return $afternoonActivity
        case 2:
            return $eveningActivity
        default:
            return .constant("")
        }
    }
    
    private func getPlaceholder(for index: Int) -> String {
        switch index {
        case 0:
            return "What did you do in the morning?"
        case 1:
            return "What did you do in the afternoon?"
        case 2:
            return "What did you do in the evening?"
        default:
            return ""
        }
    }
    
    private func setContent(for index: Int, content: String) {
        switch index {
        case 0:
            morningActivity = content
        case 1:
            afternoonActivity = content
        case 2:
            eveningActivity = content
        default:
            break
        }
    }
}

struct TimeBlockCard: View {
    let title: String
    @Binding var content: String
    let placeholder: String
    let onContentChange: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            ZStack(alignment: .topLeading) {
                if content.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 14))
                        .foregroundColor(.gray.opacity(0.6))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                }
                
                TextEditor(text: Binding(
                    get: { content },
                    set: { newValue in
                        content = newValue
                        onContentChange(newValue)
                    }
                ))
                .font(.system(size: 14))
                .frame(minHeight: 120)
                .scrollContentBackground(.hidden)
                .padding(4)
            }
            .background(Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct TimeBlocksSlider_Previews: PreviewProvider {
    static var previews: some View {
        TimeBlocksSlider(
            morningActivity: .constant(""),
            afternoonActivity: .constant(""),
            eveningActivity: .constant("")
        )
        .padding()
    }
}


//
//  CyberloafingView.swift
//  beautycase
//
//  Cyberloafing页面视图
//

import SwiftUI
import CoreData

struct CyberloafingView: View {
    @Binding var selectedDate: Date
    @State private var items: [CyberloafingItem] = []
    @State private var showingAddModal = false
    
    var body: some View {
        ZStack {
            // 页面背景 - 白色，圆角
            Color.white
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            
            VStack(spacing: 0) {
                // 标题区域
                VStack(alignment: .leading, spacing: 4) {
                    Text("Cyberloafing")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Record your daily aha moments")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 24)
                
                // 内容区域
                if items.isEmpty {
                    // 空状态
                    VStack(spacing: 16) {
                        Image(systemName: "link")
                            .font(.system(size: 48))
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Text("No content saved yet")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                        
                        Text("Tap + to capture your first aha moment")
                            .font(.system(size: 14))
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // 内容网格 - 最多5个
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 12) {
                            ForEach(items.prefix(5)) { item in
                                ContentCell(item: item)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                    }
                }
                
                Spacer()
                
                // 添加按钮
                Button(action: {
                    showingAddModal = true
                }) {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.white)
                        )
                }
                .padding(.bottom, 24)
            }
        }
        .onAppear {
            loadItems()
        }
        .onChange(of: selectedDate) { _ in
            loadItems()
        }
        .sheet(isPresented: $showingAddModal) {
            AddContentModal(selectedDate: selectedDate) {
                loadItems()
            }
        }
    }
    
    private func loadItems() {
        let persistenceController = PersistenceController.shared
        items = persistenceController.getCyberloafingItems(for: selectedDate)
    }
}

struct ContentCell: View {
    let item: CyberloafingItem
    @State private var showingTagEditor = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 封面图
            Group {
                if let thumbnailData = item.thumbnailImage,
                   let image = UIImage(data: thumbnailData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray.opacity(0.5))
                        )
                }
            }
            .frame(height: 120)
            .cornerRadius(12)
            .clipped()
            
            // 标题
            Text(item.title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
                .lineLimit(2)
            
            // 标签按钮
            HStack(spacing: 6) {
                if let fromTag = item.fromTag {
                    TagButton(icon: "tag.fill", text: fromTag, color: .blue)
                }
                if let whoTag = item.whoTag {
                    TagButton(icon: "at", text: whoTag, color: .green)
                }
                if let categoryTag = item.categoryTag {
                    TagButton(icon: "folder.fill", text: categoryTag, color: .orange)
                }
            }
        }
        .padding(12)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
        .onTapGesture {
            showingTagEditor = true
        }
        .sheet(isPresented: $showingTagEditor) {
            TagEditorView(item: item)
        }
    }
}

struct TagButton: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 10))
            Text(text)
                .font(.system(size: 11))
        }
        .foregroundColor(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

struct CyberloafingView_Previews: PreviewProvider {
    static var previews: some View {
        CyberloafingView(selectedDate: .constant(Date()))
    }
}


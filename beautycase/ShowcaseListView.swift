import SwiftUI

struct ShowcaseListView: View {
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            MountainBackground()
            
            VStack(spacing: 0) {
                // 顶部导航栏
                TopNavigationBar()
                
                // 搜索和筛选区域
                SearchAndFilterSection(searchText: $searchText)
                
                // 展柜内容列表
                ShowcaseContentList()
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

// TopNavigationBar 已移动到 SharedComponents.swift

// 搜索和筛选区域
struct SearchAndFilterSection: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("你想展示什么？", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(20)
            
            HStack(spacing: 12) {
                FilterChip(title: "我的收藏", isSelected: true)
                FilterChip(title: "2024年", isSelected: false)
                FilterChip(title: "20个物品", isSelected: false)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// 筛选标签
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? Color.blue : Color.clear)
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
            )
    }
}

// 展柜内容列表
struct ShowcaseContentList: View {
    var body: some View {
        VStack(spacing: 20) {
            MainShowcaseCard()
            
            ForEach(0..<2) { index in
                ShowcaseItemCard(index: index)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// 主要展柜卡片
struct MainShowcaseCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                VStack(alignment: .leading) {
                    Text("我的珍藏展柜")
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("个人收藏 • 2024年创建")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("20/20")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.blue)
                    
                    Text("物品数量")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
            }
            
            HStack(spacing: 12) {
                AttributeTag(icon: "bed.double", text: "20个物品")
                AttributeTag(icon: "wifi", text: "已分类")
                AttributeTag(icon: "star", text: "精选")
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<5) { index in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 70)
                            .overlay(
                                VStack {
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray)
                                    Text("图片\(index + 1)")
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                }
                            )
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, -20)
            
            HStack {
                Spacer()
                Text("124$")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.orange)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// 展柜项目卡片
struct ShowcaseItemCard: View {
    let index: Int
    
    var body: some View {
        HStack(spacing: 15) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 80, height: 60)
                .overlay(
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text("展柜项目\(index + 1)")
                    .font(.system(size: 16, weight: .medium))
                
                Text("2024年收藏 • 个人物品")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                HStack(spacing: 8) {
                    AttributeTag(icon: "tag", text: "收藏品")
                    AttributeTag(icon: "heart", text: "珍贵")
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5) {
                Text("\(100 + index * 10)$")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.orange)
                
                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(15)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

// AttributeTag 已移动到 SharedComponents.swift

struct ShowcaseListView_Previews: PreviewProvider {
    static var previews: some View {
        ShowcaseListView()
    }
}

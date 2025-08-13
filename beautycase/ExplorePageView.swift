import SwiftUI

struct ExplorePageView: View {
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 顶部导航栏
                TopNavigationBar()
                
                // 搜索区域
                SearchSection(
                    searchText: $searchText,
                    placeholder: "探索精彩展柜...",
                    filters: []
                )
                
                // 热门展柜
                PopularShowcasesSection()
                
                // 推荐内容
                RecommendedContentSection()
                
                // 底部留白，确保底部tabs可见
                Spacer(minLength: 120)
            }
        }
    }
}

// SearchSection 已移动到 SharedComponents.swift

// 热门展柜区域
struct PopularShowcasesSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("热门展柜")
                .font(.system(size: 20, weight: .bold))
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<5) { index in
                        PopularShowcaseCard(index: index)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 20)
    }
}

// 热门展柜卡片
struct PopularShowcaseCard: View {
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 图片
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 150, height: 100)
                .overlay(
                    VStack {
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                        Text("热门展柜\(index + 1)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                )
            
            // 标题
            Text("精美收藏\(index + 1)")
                .font(.system(size: 14, weight: .medium))
                .lineLimit(1)
            
            // 用户信息
            HStack {
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 20, height: 20)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.caption)
                            .foregroundColor(.blue)
                    )
                
                Text("用户\(index + 1)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .font(.caption)
                        .foregroundColor(.red)
                    Text("\(100 + index * 20)")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(width: 150)
        .padding(12)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

// 推荐内容区域
struct RecommendedContentSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("为你推荐")
                .font(.system(size: 20, weight: .bold))
                .padding(.horizontal, 20)
            
            VStack(spacing: 12) {
                ForEach(0..<3) { index in
                    RecommendedContentCard(index: index)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 20)
    }
}

// 推荐内容卡片
struct RecommendedContentCard: View {
    let index: Int
    
    var body: some View {
        HStack(spacing: 15) {
            // 图片
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 80, height: 60)
                .overlay(
                    Image(systemName: "sparkles")
                        .foregroundColor(.orange)
                )
            
            // 内容
            VStack(alignment: .leading, spacing: 6) {
                Text("推荐内容\(index + 1)")
                    .font(.system(size: 16, weight: .medium))
                
                Text("发现更多精彩收藏，探索无限可能")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                HStack {
                    Text("2小时前")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "heart")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Spacer()
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

struct ExplorePageView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePageView()
    }
}

import SwiftUI

struct ProfilePageView: View {
    @State private var isEditingProfile = false
    
    var body: some View {
        VStack(spacing: 0) {
            // 顶部导航栏
            TopNavigationBar()
            
            // 用户信息区域
            UserProfileSection(isEditingProfile: $isEditingProfile)
            
            // 统计信息
            StatisticsSection()
            
            // 功能菜单
            MenuSection()
            
            Spacer()
        }
    }
}

// 用户信息区域
struct UserProfileSection: View {
    @Binding var isEditingProfile: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            // 头像
            Button(action: {
                isEditingProfile.toggle()
            }) {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                        )
                    
                    // 编辑图标
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Image(systemName: "pencil")
                                .font(.caption)
                                .foregroundColor(.blue)
                        )
                        .offset(x: 35, y: 35)
                }
            }
            
            // 用户信息
            VStack(spacing: 8) {
                Text("我的收藏家")
                    .font(.system(size: 24, weight: .bold))
                
                Text("热爱收藏，分享美好")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Text("加入时间：2024年")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            // 编辑按钮
            Button(action: {
                isEditingProfile.toggle()
            }) {
                Text("编辑资料")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.blue)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.blue.opacity(0.3), lineWidth: 1)
                    )
                    .cornerRadius(15)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// 统计信息区域
struct StatisticsSection: View {
    var body: some View {
        HStack(spacing: 20) {
            StatisticItem(title: "展柜", value: "12", icon: "house.fill")
            StatisticItem(title: "收藏", value: "156", icon: "heart.fill")
            StatisticItem(title: "关注", value: "89", icon: "person.2.fill")
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// 统计项目
struct StatisticItem: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.blue)
            
            Text(value)
                .font(.system(size: 20, weight: .bold))
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(15)
    }
}

// 功能菜单区域
struct MenuSection: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("功能设置")
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            VStack(spacing: 8) {
                MenuItem(icon: "gear", title: "设置", subtitle: "应用设置和偏好")
                MenuItem(icon: "bell", title: "通知", subtitle: "消息和提醒设置")
                MenuItem(icon: "shield", title: "隐私", subtitle: "隐私和安全设置")
                MenuItem(icon: "questionmark.circle", title: "帮助", subtitle: "使用帮助和反馈")
                MenuItem(icon: "info.circle", title: "关于", subtitle: "版本信息和说明")
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 20)
    }
}

// 菜单项目
struct MenuItem: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        Button(action: {
            // 菜单项点击
        }) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                    .frame(width: 30)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(15)
            .background(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(15)
        }
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}

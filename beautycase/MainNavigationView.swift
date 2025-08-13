import SwiftUI

struct MainNavigationView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                // 背景
                MountainBackground()
                
                // 内容区域
                VStack(spacing: 0) {
                    // 根据选中的tab显示不同内容
                    switch selectedTab {
                    case 0:
                        HomePageView()
                    case 1:
                        ExplorePageView()
                    case 2:
                        ProfilePageView()
                    default:
                        HomePageView()
                    }
                    
                    // 自定义底部导航栏
                    BottomTabBar(selectedTab: $selectedTab)
                }
            }
            .ignoresSafeArea()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}

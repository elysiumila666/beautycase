//
//  HomePageView.swift
//  beautycase
//
//  深色主题首页视图
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        ZStack {
            // 深色背景
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 顶部状态栏区域
                HStack {
                    Text("11:30")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    HStack(spacing: 5) {
                        Image(systemName: "signal")
                        Image(systemName: "wifi")
                        Image(systemName: "battery.100")
                    }
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
        }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // 主要内容区域
                VStack(spacing: 30) {
                    Spacer()
                
                    // 欢迎文字
                    VStack(spacing: 12) {
                        Text("欢迎")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                    
                        Text("开始您的收藏之旅")
                            .font(.system(size: 18))
                            .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
            }
                .padding(.horizontal, 20)
        }
    }
        .preferredColorScheme(.dark)
        }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .preferredColorScheme(.dark)
    }
}

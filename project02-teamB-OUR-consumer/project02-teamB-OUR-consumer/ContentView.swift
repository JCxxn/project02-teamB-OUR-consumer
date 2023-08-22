//
//  ContentView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 전민돌 on 8/22/23.
//

import SwiftUI

//Color extension확장하여 Hex Color 받아서 바꾸기
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0
        )
    }
}

struct ContentView: View {
    
    enum TabItem {
            case feed, studyFeed, recruitAdd, alarm, myPage
        }

        @State private var selectedTab: TabItem = .feed
        @State private var mainLogoToggle: Bool = true
    
    let hexColor: String = "#090580" //메인컬러로 변경
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                //FeedView
                Image(systemName: "house.fill")
                    .tag(TabItem.feed)
                    .tabItem {
                        Label("피드", systemImage: "house.fill")
                    }
                //StudyFeedView
                Image(systemName: "book.fill")
                    .tag(TabItem.studyFeed)
                    .tabItem {
                        Label("스터디모집", systemImage: "book.fill")
                    }
                //RecruitAddView
                Image(systemName: "plus.app.fill")
                    .tag(TabItem.recruitAdd)
                    .tabItem {
                        Label("작성하기", systemImage: "plus.app.fill")
                    }
                //AlarmView
                Image(systemName: "bell.fill")
                    .tag(TabItem.alarm)
                    .tabItem {
                        Label("알림", systemImage: "bell.fill")
                    }
                //MyPageView
                Image(systemName: "person.fill")
                    .tag(TabItem.myPage)
                    .tabItem {
                        Label("마이페이지", systemImage: "person.fill")
                    }
            }
            .tint(Color(hex: hexColor)) // 메인컬러로 변경
            .navigationBarItems(leading: leadingBarItem)
        }
    }

    @ViewBuilder
    var leadingBarItem: some View {
        if mainLogoToggle && selectedTab != .alarm && selectedTab != .myPage  {
            Image("OUR_Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

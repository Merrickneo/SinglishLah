//
//  NewHomeView.swift
//  SinglishLah
//
//  Created by Ryu Suzuki on 14/6/22.
//

import SwiftUI

struct TabHomeView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    @State private var selection = 0
    @EnvironmentObject var service: SessionServiceImpl
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
         
            SinglishSearchPage()
                .tabItem {
                    Image(systemName: "bookmark.circle.fill")
                    Text("Translate")
                }
                .tag(1)
         
            QuizView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "video.circle.fill")
                    Text("Learn")
                }
                .tag(2)
         
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(3)
        }
    }
}

struct TabHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabHomeView()
            .environmentObject(SessionServiceImpl())
    }
}

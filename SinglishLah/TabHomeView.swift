//
//  NewHomeView.swift
//  SinglishLah
//
//  Created by Ryu Suzuki on 14/6/22.
//

import SwiftUI

struct NewHomeView: View {
    @State private var selection = 0
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
         
            Text("Learn Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "video.circle.fill")
                    Text("Learn")
                }
                .tag(2)
         
            Text("Profile Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(3)
        }
    }
}

struct NewHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewHomeView()
    }
}

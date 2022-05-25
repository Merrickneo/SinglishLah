//
//  HomePageView.swift
//  SinglishLah
//
//  Created by Ryu Suzuki on 23/5/22.
//

import SwiftUI

let backgroundGradient = LinearGradient(
    gradient: Gradient(colors: [Color.blue, Color.white]),
    startPoint: .top, endPoint: .bottom)

struct HomePageView: View {
    var body: some View {
        ZStack {
            backgroundGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Welcome Back, User!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()
                Text("Level 10")
                Spacer()
                Text("insert progress bar and trophy")
                Spacer()
                Text("100XP to Level 11")
                    .font(.subheadline)
                Spacer()
                                
                HStack {
                    Text("Yo")
                    Image(systemName: "signature")
                }
            }
        }
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

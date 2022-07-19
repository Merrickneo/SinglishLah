//
//  ContentView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 12/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                            ExtractedView()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Welcome Back")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct ExtractedView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Image("Microphone")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)
            
            Text("SinglishLah!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .opacity(0.8)
            
            Text("Your one-stop Singlish learning platform")
            
            Text("Insert slogan here")
                .opacity(0.8)
        }
        .padding(16)
        .frame(width: 252, height: 329)
        .background(LinearGradient(
            gradient: Gradient(stops: [
                .init (color: Color(#colorLiteral(red: 1, green: 0.7450980544090271, blue: 0.04313725605607033, alpha: 1)), location: 0),
                .init (color: Color(#colorLiteral(red: 0.22745098173618317, green: 0.5254902243614197, blue: 1, alpha: 1)), location: 1)]),
            startPoint:UnitPoint(x:0.5002249700310126,
                                 y: 3.0834283490377423e-7),
            endPoint: UnitPoint(x:
                                    -0.0016390833199537713, y:
                                    0.977085239704672)))
        .cornerRadius(30)
    }
}

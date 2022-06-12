//
//  SinglishSearchPage.swift
//  SinglishLah
//
//  Created by Merrick Neo on 9/6/22.
//

import SwiftUI
import InstantSearchVoiceOverlay

struct SinglishSearchPage: View {
    @State var name: String = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TextBoxView()
                        .padding()
                    Text(speechToText())
                    TextField("Hello", text: $name)
                    Text("Saved Words")
                    HStack {
                        BottomNavBarItem(image: Image(systemName: "house")) {}
                        BottomNavBarItem(image: Image(systemName: "magnifyingglass.circle.fill")) {}
                        BottomNavBarItem(image: Image(systemName: "book")) {}
                        BottomNavBarItem(image: Image(systemName: "person")) {}
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
    }
}
// MARK: - Functions for Translating Speech
func speechToText() -> String {
    return "This is the translated text"
}

struct TextBoxView: View {
    @State private var search: String = ""
    var body: some View {
        VStack {
            Text("Translate a word")
                .font(.system(size: 16))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("enter word/phrase", text: $search)
                    .frame(height: 40)
            }.padding()
                .background(Color.white)
                .cornerRadius(10.0)
        }
    }
}

struct SinglishSearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SinglishSearchPage()
    }
}

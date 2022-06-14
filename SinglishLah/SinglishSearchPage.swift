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

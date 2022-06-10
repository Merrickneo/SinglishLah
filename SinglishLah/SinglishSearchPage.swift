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
            VStack {
                Text(speechToText())
                TextField("Hello", text: $name)
            }
        }
    }
}
// MARK: - Functions for Translating Speech
func speechToText() -> String {
    return "This is the translated text"
}


struct SinglishSearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SinglishSearchPage()
    }
}

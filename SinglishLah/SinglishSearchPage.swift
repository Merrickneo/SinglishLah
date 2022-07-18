//
//  SinglishSearchPage.swift
//  SinglishLah
//
//  Created by Merrick Neo on 9/6/22.
//

import AVFoundation
import Foundation
import Speech
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import CoreML
import AVKit

struct SinglishSearchPage: View {
    @State var searchWord: String = ""
    @ObservedObject var model = HistoryModel()
    @State private var showWordDescription = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TextBoxView(model: model)
                        .padding()
                    // Get from history last 3 words
                    Text("Saved Words")
                    List(model.list) {item in
                        Button {
                            self.showWordDescription.toggle()
                        } label: {
                            Text(item.word)
                        }
                        .sheet(isPresented: $showWordDescription) {
                            WordDescriptionView(word: item)
                        }
                    }
                }
            }
        }
    }
    init() {
        model.getData()
    }
}



// MARK: - Functions for Translating Speech
func initialiseModel() -> SinglishToText? {
    do {
        let config = MLModelConfiguration()
        
        let model = try SinglishToText(configuration: config)

        return model
    } catch {
        
    }
    return nil
}

func speechToText() -> String {
    return "This is the translated text"
}

// MARK: - TextBox UI

struct TextBoxView: View {
    @State var input: String = ""
    @State private var searchResult = false
    @State var model: HistoryModel
    @State var wordToSearch: wordData?    //@ObservedObject private var model = HistoryModel()
    
    var body: some View {
        VStack {
            Text("Translate a word")
                .font(.system(size: 16))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("enter word/phrase", text: $input)
                    .frame(height: 40)
                Button {
                    // Do a search of the Data
                    for item in model.list {
                        if item.word == input.lowercased() {
                            wordToSearch = item
                        }
                    }
                    self.searchResult.toggle()
                } label: {
                    Text("Search!")
                }
                .sheet(isPresented: $searchResult,
                       onDismiss: {
                    wordToSearch = wordData(id: "Invalid Word", word: "Word not found", description: "NIL")
                }, content: {
                    WordDescriptionView(word: wordToSearch ?? wordData(id: "Invalid Word", word: "Word not found", description: "NIL")
)
                })
                
                
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


// This is for the recording of audio
//Button {
//    AVAudioSession.sharedInstance().requestRecordPermission { granted in
//        if granted {
//
//        } else {
//            // Ask user to enable recording permissions
//        }
//    }
//} label: {
//    Image(systemName: "mic.fill")
//}

// MARK: - Functions to start and stop recording

//TODO

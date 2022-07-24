//
//  SinglishSearchPage.swift
//  SinglishLah
//
//  Created by Merrick Neo on 9/6/22.
//

import Foundation
import Speech
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import CoreML
import AVFAudio

struct SinglishSearchPage: View {
    @State var searchWord: String = ""
    @ObservedObject var model = WordDatabase()
    @State private var showWordDescription = false
    @StateObject var searchHistory = SearchHistory()
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TextBoxView()
                        .padding()
                        .environmentObject(model)
                        .environmentObject(searchHistory)
                    // Get from history last 3 words
                    Text("Searched Words")

                    // To be updated later
                    HistoryOfWords().environmentObject(searchHistory)
                    
                    List(model.list) {item in
                        if item.searched == true {
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
    }
    init() {
        model.getData()
    }
}


struct HistoryOfWords: View {
    @EnvironmentObject var searchHistory: SearchHistory
    @State private var showWordDescription: Bool = false
    
    var body: some View {
        if searchHistory.searchedWords.count > 0 {
            ScrollView {
                ForEach(searchHistory.searchedWords, id: \.id) { item in
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

func requestPermissionToRecord() -> Bool{
    var accessible = true
    AVAudioSession.sharedInstance().requestRecordPermission { granted in
        if !granted {
            accessible = false
        }
        print(granted)
    }
    return accessible
}


// MARK: - TextBox UI

struct TextBoxView: View {
    @State var input: String = ""
    @State private var searchResult = false
    @EnvironmentObject var model: WordDatabase
    @State var wordToSearch: wordData?
    @EnvironmentObject var searchHistory: SearchHistory
    
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
                            if item.searched == false {
                                item.toggleSearched()
                                model.toggleWordSearched(word: item)
                                model.getData()
                            }
                        }
                    }
                    self.searchResult.toggle()
                } label: {
                    Text("Search!")
                }
                .sheet(isPresented: $searchResult,
                       onDismiss: {
                    wordToSearch = wordData(id: "Invalid Word", word: "Word not found", description: "NIL", example: "", searched: false)
                }, content: {
                    WordDescriptionView(word: wordToSearch ?? wordData(id: "Invalid Word", word: "Word not found", description: "NIL", example: "", searched: false)
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

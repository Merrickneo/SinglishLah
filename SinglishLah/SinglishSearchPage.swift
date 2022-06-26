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
import CoreML

struct SinglishSearchPage: View {
    @State var name: String = ""
    @State var searchWord: String = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TextBoxView()
                        .padding()
                    TextField("Hello", text: $name)
                    // Get from history last 3 words
                    Text("Saved Words")
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
        // Do nothing
    }
    return nil
}

func getSpeechPrediction(model: SinglishToText) -> String {
    //model.prediction(audioSamples: <#T##MLShapedArray<Float>#>)
    return "placeholder"
}


func speechToText() -> String {
    return "This is the translated text"
}

// MARK: - TextBox UI

struct TextBoxView: View {
    @State private var search: String = ""
    
    // Initilalise our model
    
    
    var body: some View {
        VStack {
            Text("Translate a word")
                .font(.system(size: 16))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("enter word/phrase", text: $search)
                    .frame(height: 40)
                Button {
                    AVAudioSession.sharedInstance().requestRecordPermission { granted in
                        if granted {
                            
                        } else {
                            // Ask user to enable recording permissions
                        }
                    }
                } label: {
                    Image(systemName: "mic.fill")
                }

                
            }.padding()
                .background(Color.white)
                .cornerRadius(10.0)
        }
    }
}

// MARK: - Functions to start and stop recording

//TODO



struct SinglishSearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SinglishSearchPage()
    }
}

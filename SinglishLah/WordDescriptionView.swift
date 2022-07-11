//
//  WordDescriptionView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 11/7/22.
//

import SwiftUI

struct WordDescriptionView: View {
    var word: wordData
    var body: some View {
        HStack {
            Text(word.word)
                .bold()
            Text(word.description)
        }
    }
}

struct wordData: Identifiable {
    var id: String
    var word: String
    var description: String
    // Add in example sentences later
    // var exampleSentence: String
}

struct WordDescriptionView_Previews: PreviewProvider {
    
    static let wordPreview = wordData(id: "1",
                                      word: "Act blur",
                                      description: "To feign ignorance")
    
    static var previews: some View {
        WordDescriptionView(word: wordPreview)
    }
}

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


struct WordDescriptionView_Previews: PreviewProvider {
    
    static let wordPreview = wordData(id: "1",
                                      word: "Act blur",
                                      description: "To feign ignorance",
                                      example: "",
                                      searched: false)
    
    static var previews: some View {
        WordDescriptionView(word: wordPreview)
    }
}

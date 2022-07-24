//
//  wordModel.swift
//  SinglishLah
//
//  Created by Merrick Neo on 18/7/22.
//

import Foundation

class wordData: Identifiable {
    var id: String
    var word: String
    var description: String
    var example: String
    @Published var searched: Bool
    
    func toggleSearched() {
        self.searched = true
    }
    init (id: String, word: String, description: String, example: String, searched: Bool) {
        self.id = id
        self.word = word
        self.description = description
        self.example = example
        self.searched = searched
    }
}

//
//  SearchedWords.swift
//  SinglishLah
//
//  Created by Merrick Neo on 23/7/22.
//

import Foundation


class SearchHistory: ObservableObject {
    @Published private(set) var searchedWords: [wordData] = []
    
    func addToHistory(word: wordData) {
        searchedWords.append(word)
    }
}

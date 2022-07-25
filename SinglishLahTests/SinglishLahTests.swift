//
//  SinglishLahTests.swift
//  SinglishLahTests
//
//  Created by Merrick Neo on 12/5/22.
//

import XCTest
import Firebase
@testable import SinglishLah

class SinglishLahTests: XCTestCase {
    
    
    // Check if app can reset one's password and is connected to Firebase
    func connFirebase() {
        let auth = Auth.auth()
        var success = false
        do {
            auth.sendPasswordReset(withEmail: "merrickneo@gmail.com")
            success.toggle()
            print("HI")
        }
        catch {
            print("Not able to reset password")
        }
        XCTAssertEqual(success, true)
    }
    
    // Remove from CartManager
    func testRemoveVouchers() {
        
        let cartManager = CartManager()
        
        cartManager.addToCart(voucher: Voucher(name: "This is a $5 voucher", amount: 5))
        
        cartManager.removeAllVouchers()

        XCTAssertEqual(cartManager.vouchers.count, 0)
    }
    
    // Check if searching a word adds it to a user's history
    func wordAddedToHistory() {
        let searchHistory = SearchHistory()
        
        let word = wordData(id: "1", word: "abit", description: "a little bit", example: "I am abit hungry", searched: false)
        
        word.searched = true
        
        if word.searched == true {
            searchHistory.addToHistory(word: word)
        }
        XCTAssertEqual(searchHistory.searchedWords.count, 1)
    }
    
    
}

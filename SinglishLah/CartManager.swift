//
//  CartManager.swift
//  SinglishLah
//
//  Created by Merrick Neo on 18/7/22.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var vouchers: [Voucher] = []
    @Published private(set) var total: Int = 0
    
    func addToCart(voucher: Voucher) {
        vouchers.append(voucher)
        total += voucher.amount
    }
    
    func removeFromCart(voucher: Voucher) {
        var index: Int?
        for i in stride(from: 0, to: vouchers.count, by: 1) {
            if vouchers[i].amount == voucher.amount {
                index = i
            }
        }
        if let index = index {
            vouchers.remove(at: index)
            total -= voucher.amount
        }
    }
    
    func removeAllVouchers() {
        vouchers.removeAll()
    }
}

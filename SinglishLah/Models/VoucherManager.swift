//
//  VoucherManager.swift
//  SinglishLah
//
//  Created by Merrick Neo on 24/7/22.
//

import Foundation

class VoucherManager: ObservableObject {
    @Published private(set) var vouchers: [Voucher] = []
    
    func addToList(voucher: Voucher) {
        vouchers.append(voucher)
    }
    
    func removeFromList(voucher: Voucher) {
        var index: Int?
        
        for i in stride(from: 0, to: vouchers.count, by: 1) {
            if vouchers[i].amount == voucher.amount {
                index = i
            }
        }
        if let index = index {
            vouchers.remove(at: index)
        }
    }
}

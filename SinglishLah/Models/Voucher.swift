//
//  VoucherModel.swift
//  SinglishLah
//
//  Created by Merrick Neo on 18/7/22.
//

import Foundation

struct Voucher: Identifiable {
    var id = UUID()
    var name: String
    var image = "voucher_redemption"
    var amount: Int
}

var voucherList = [Voucher(name: "$5 dollars", amount: 5),
                   Voucher(name: "$10 dollars", amount: 10),
                   Voucher(name: "$15 dollars", amount: 15),
                   Voucher(name: "$20 dollars", amount: 20)]


//
//  CartView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 18/7/22.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        ScrollView {
            if cartManager.vouchers.count > 0 {
                ForEach(cartManager.vouchers, id: \.id) { voucher in
                    VoucherRow(voucher: voucher)
                }
                HStack {
                    Text("Your cart total is")
                    Spacer()
                    Text("$\(cartManager.total).00")
                        .bold()
                }
            } else {
                Text("Your cart is empty")
            }
        }
        .navigationTitle(Text("My Cart"))
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}

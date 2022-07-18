//
//  VoucherRedemptionView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 18/7/22.
//

import SwiftUI

struct VoucherRedemptionView: View {
    @StateObject var cartManager = CartManager()
    private var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(voucherList, id: \.id) { voucher in
                        VoucherCard(voucher: voucher)
                    }
                }
                .padding()
            }
            .navigationTitle(Text("Exchange for Vouchers!"))
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    CartButton(numberOfVouchers: cartManager.vouchers.count)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct VoucherRedemptionView_Previews: PreviewProvider {
    static var previews: some View {
        VoucherRedemptionView()
    }
}

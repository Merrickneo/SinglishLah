//
//  VoucherRedemptionView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 18/7/22.
//

import SwiftUI

struct VoucherRedemptionView: View {
    @StateObject var cartManager = CartManager()
    @StateObject var voucherManager = VoucherManager()
    @State var redeemVouchers: Bool = false
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(voucherList, id: \.id) { voucher in
                        VoucherCard(voucher: voucher)
                            .environmentObject(cartManager)
                    }
                }
                .padding()
                Button {
                    redeemVouchers.toggle()
                    print("HI")
                } label: {
                    Image("redeem_voucher")
                        .resizable()
                        .frame(width:75, height: 75)
                        
                }
                .position(x: 380, y: 150)
            }
            .navigationTitle(Text("Exchange EXP"))
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                        .environmentObject(voucherManager)
                } label: {
                    CartButton(numberOfVouchers: cartManager.vouchers.count)
                }
            }
        }
        .sheet(isPresented: $redeemVouchers) {
            RedeemVouchersView()
                .environmentObject(voucherManager)
        }
        
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct VoucherRedemptionView_Previews: PreviewProvider {
    static var previews: some View {
        VoucherRedemptionView()
    }
}

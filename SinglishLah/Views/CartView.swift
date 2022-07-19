//
//  CartView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 18/7/22.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State var redeemed: Bool = false
    var body: some View {
        ScrollView {
            if cartManager.vouchers.count > 0 {
                ForEach(cartManager.vouchers, id: \.id) { voucher in
                    VoucherRow(voucher: voucher)
                }
                HStack {
                    Text("Your cart total is")
                    Text("$\(cartManager.total).00")
                        .bold()
                    Spacer()
                }
                .padding()
                Button {
                    redeemed.toggle()
                    if redeemed == true {
                        cartManager.removeAllVouchers()
                    }
                    print(redeemed)
                } label: {
                    Text("Redeem EXP")
                }
                .buttonStyle(GrowingButton())
            } else {
                Text("Your cart is empty")
            }
        }
        .padding(.top)
        .navigationTitle(Text("My Cart"))
        .navigationBarBackButtonHidden(false)
        .alert("Successfully redeemed", isPresented: $redeemed) {
            Button("OK", role: .cancel) {
                redeemed.toggle()
            }
        }
    }
}



struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}

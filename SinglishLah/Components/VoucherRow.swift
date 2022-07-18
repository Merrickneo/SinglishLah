//
//  VoucherRow.swift
//  SinglishLah
//
//  Created by Merrick Neo on 18/7/22.
//

import SwiftUI

struct VoucherRow: View {
    @EnvironmentObject var cartManager: CartManager
    var voucher: Voucher
    var body: some View {
        HStack(spacing: 20) {
            Image("voucher_redemption")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 10) {
                Text(voucher.name)
                    .bold()
                Text("\(voucher.amount)")
            }
            Spacer()
            Image(systemName: "trash")
                .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                .onTapGesture {
                    cartManager.removeFromCart(voucher: voucher)
                }
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct VoucherRow_Previews: PreviewProvider {
    static var previews: some View {
        VoucherRow(voucher: voucherList[2])
            .environmentObject(CartManager())
    }
}

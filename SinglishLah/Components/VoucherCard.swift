//
//  VoucherCard.swift
//  SinglishLah
//
//  Created by Merrick Neo on 18/7/22.
//

import SwiftUI

struct VoucherCard: View {
    @EnvironmentObject var cartManager: CartManager
    var voucher: Voucher
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                Image(voucher.image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 180)
                    .scaledToFit()
                VStack(alignment: .leading) {
                    Text(voucher.name)
                        .bold()
                    
                    Text("$" + "\(voucher.amount)")
                        .font(.caption)
                }
                .padding()
                .frame(width: 180, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(3)
            }
            .frame(width: 180, height: 250)
        .shadow(radius: 3)
            
            Button {
                cartManager.addToCart(voucher: voucher)
            } label: {
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(50)
                    .padding()
            }

        }
    }
}

struct VoucherCard_Previews: PreviewProvider {
    static var previews: some View {
        VoucherCard(voucher: voucherList[0])
            .environmentObject(CartManager())
    }
}

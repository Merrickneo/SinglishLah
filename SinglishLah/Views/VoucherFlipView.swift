//
//  VoucherFlipView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 20/7/22.
//

import SwiftUI

struct VoucherFlipView<Front, Back>: View where Front: View, Back: View{
    var front: () -> Front
    var back: () -> Back
    var voucher: Voucher
    @State var flipped: Bool = false
    init(@ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back,
         voucher: Voucher) {
        self.front = front
        self.back = back
        self.voucher = voucher
    }
    var body: some View {
        ZStack {
            if flipped {
                back()
            } else {
                front()
            }
        }
        .cornerRadius(20)
        .frame(width: 180)
        .scaledToFit()
        .padding()
        .onTapGesture {
            flipVoucher()
        }
    }
    
    func flipVoucher() {
        flipped.toggle()
    }
}

struct VoucherFront: View {
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
        }
    }
}

struct VoucherBack: View {
    var voucher: Voucher
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                Image(voucher.image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 180)
                    .scaledToFit()
                    .opacity(0.1)
                VStack(alignment: .center) {
                    Text("Scan to redeem")
                    // Adjust alignment later
                    Image(voucher.back_image)
                        .resizable()
                        .frame(width: 90, height: 100)
                        .scaledToFit()
                        .padding()
                }
                
//                VStack(alignment: .leading) {
//                    Text(voucher.name)
//                        .bold()
//
//                    Text("$" + "\(voucher.amount)")
//                        .font(.caption)
//                }
//                .padding()
//                .frame(width: 180, alignment: .leading)
//                .background(.ultraThinMaterial)
//                .cornerRadius(3)
            }
            .frame(width: 180, height: 250)
            .shadow(radius: 3)
        }
    }
}


struct VoucherFlipView_Previews: PreviewProvider {
    static var previews: some View {
        VoucherFlipView(front: {
            VoucherFront(voucher: voucherList[0])
        }, back: {
                VoucherBack(voucher: voucherList[2])
            },
            voucher: voucherList[0]
                        
        )
        VoucherFront(voucher: voucherList[1])
    }
}


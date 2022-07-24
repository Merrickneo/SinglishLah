//
//  RedeemVouchersView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 24/7/22.
//

import SwiftUI

struct RedeemVouchersView: View {
    @EnvironmentObject var voucherManager: VoucherManager
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    var body: some View {
        
        ScrollView {
            if voucherManager.vouchers.count == 0 {
                Text("You have no vouchers")
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(voucherManager.vouchers, id: \.id) { voucher in
                        VoucherFlipView(front: {
                            VoucherFront(voucher: voucher)
                        }, back: {
                                VoucherBack(voucher: voucher)
                            },
                            voucher: voucher
                        )
                        
                    }
                }
            }
        }
    }
}

struct RedeemVouchersView_Previews: PreviewProvider {
    static var previews: some View {
        RedeemVouchersView()
            .environmentObject(VoucherManager())
    }
}

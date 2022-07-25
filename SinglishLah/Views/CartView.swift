//
//  CartView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 18/7/22.
//

import SwiftUI
import Firebase

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var voucherManager: VoucherManager
    @State var redeemed: Bool = false
    @State var failedRedemption: Bool = false
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
                    redeemed = purchaseVouchers(cartManager: cartManager, voucherManager: voucherManager)
                    failedRedemption = !redeemed
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
//        .alert("Not enough EXP", isPresented: $failedRedemption) {
//            Button("OK", role: .cancel) {
//                failedRedemption.toggle()
//            }
//        }
    }
}

func purchaseVouchers(cartManager: CartManager, voucherManager: VoucherManager) -> Bool {
    let ref = Database.database().reference()
    var exp: Int = 0
    var requiredExp = 0
    var currentVouchers: Dictionary = [String: Int]()
    
    for voucher in cartManager.vouchers {
        requiredExp = 100 * voucher.amount
        voucherManager.addToList(voucher: Voucher(name: "$\(voucher.amount) dollars", amount: voucher.amount))
    }
    print(voucherManager.vouchers)
    
    let userID = Auth.auth().currentUser?.uid
    ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { snapshot in
        let value = snapshot.value as? NSDictionary
        exp = value!["EXP"] as! Int
        currentVouchers = value!["Vouchers"] as! Dictionary
    }) { error in
        print(error.localizedDescription)
    }
    
    if exp >= requiredExp {
        exp -= requiredExp
        for voucher in cartManager.vouchers {
            currentVouchers[String(voucher.amount)]! += 1
        }
        
        ref.child("users").child(userID!).setValue(["EXP": exp,
                                                    "Vouchers": currentVouchers])
        return true
    }
    return true
}



struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}

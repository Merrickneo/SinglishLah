//
//  ProfileView.swift
//  SinglishLah
//
//  Created by Ryu Suzuki on 23/6/22.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @EnvironmentObject var service: SessionServiceImpl
    @State var changePassword: Bool = false
    @State var redeemVouchers: Bool = false

    var body: some View {
        NavigationView {
            VStack{
                Button {
                    redeemVouchers.toggle()
                } label: {
                    Text("Exchange for Vouchers")
                }
                .sheet(isPresented: $redeemVouchers) {
                } content: {
                    VoucherRedemptionView()
                }
                
                // Change password through sending an email to the user's email
                Button {
                    changePassword.toggle()
                } label: {
                    Text("Change Password")
                }
                .sheet(isPresented: $changePassword) {
                } content: {
                    ChangePasswordView()
                }
                
                Button(action: {
                    service.logout()
                }, label: {
                    Text("Sign Out")
                        .foregroundColor(Color.blue)
                })
            }
        }
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

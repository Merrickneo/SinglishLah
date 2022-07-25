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
            List {
                Button {
                    redeemVouchers.toggle()
                } label: {
                    HStack {
                        Image("voucher_redemption")
                            .resizable()
                            .frame(width: 50,  height: 50)
                        Text(" Exchange for Vouchers")
                    }
                }
                .sheet(isPresented: $redeemVouchers) {
                } content: {
                    VoucherRedemptionView()
                }
                .frame(height: 60)
                
                // Change password through sending an email to the user's email
                Button {
                    changePassword.toggle()
                } label: {
                    HStack {
                        Image("change_password")
                            .resizable()
                            .frame(width: 58, height: 60)
                        Text("Change Password")
                    }
                }
                .sheet(isPresented: $changePassword) {
                } content: {
                    ChangePasswordView()
                }
                .frame(height: 60)
                
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        service.logout()
                    }, label: {
                        Text("Sign Out")
                    })
                    .frame(height: 60)
                    
                    Spacer()
                }
            }
            .navigationTitle("Profile Page")
        }
        
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


//NavigationView {
//    VStack{
//        Button {
//            redeemVouchers.toggle()
//        } label: {
//            Text("Exchange for Vouchers")
//        }
//        .sheet(isPresented: $redeemVouchers) {
//        } content: {
//            VoucherRedemptionView()
//        }
//
        // Change password through sending an email to the user's email
//        Button {
//            changePassword.toggle()
//        } label: {
//            Text("Change Password")
//        }
//        .sheet(isPresented: $changePassword) {
//        } content: {
//            ChangePasswordView()
//        }
//
//
//    }
////    .navigationTitle("Profile Page")
////}

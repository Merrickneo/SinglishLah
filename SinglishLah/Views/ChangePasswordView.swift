//
//  ChangePasswordView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 12/7/22.
//

import SwiftUI
import Firebase

struct ChangePasswordView: View {
    @State var email: String = ""
    @State var username: String = ""
    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @State var success: Bool = false
    private var systemImage = "envelope"
    private let textFieldLeading: CGFloat = 30
    
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Change your password")
            VStack {
                TextField("Email", text: $email)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                           minHeight: 44,
                           alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.leading, systemImage == nil ? textFieldLeading / 2 : textFieldLeading)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(
                        ZStack(alignment: .leading) {
                            if let systemImage = systemImage {
                                Image(systemName: systemImage)
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.leading, 5)
                                    .foregroundColor(Color.gray.opacity(0.5))
                            }
                            RoundedRectangle(cornerRadius: 10,
                                             style: .continuous)
                                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                        }
                    )
            }
            Button {
                if email != "" {
                    success = changePassword(email: email.lowercased())
                }
            } label: {
                Text("Change Password!")
            }
            .alert("Please reset your password by clicking on the link sent to your email", isPresented: $success) {
                Button("OK", role: .cancel) {
                    email = ""
                    success.toggle()
                }
            }
        }
    }
}

// Fix the error where the success variable is not toggling
func changePassword(email: String) -> Bool {
    let auth = Auth.auth()
    var success: Bool = true
    
    auth.sendPasswordReset(withEmail: email) { error in
        if (error == nil){
            success.toggle()
        }
    }
    return success
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}

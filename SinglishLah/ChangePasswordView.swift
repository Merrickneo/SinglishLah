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
    
    var body: some View {
        Text("Change your password")
        TextField("Enter your email here", text: $email)
            .frame(height: 40)
            .disableAutocorrection(true)
            .autocapitalization(.none)
        Button {
            success = changePassword(email: email.lowercased())
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

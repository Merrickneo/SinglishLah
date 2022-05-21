//
//  FirebaseAuth.swift
//  SinglishLah
//
//  Created by Merrick Neo on 16/5/22.
//

import SwiftUI

struct RegistrationPageView: View {
    
    @State var email = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Microphone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack {
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Sign In")
        }
    }
}

struct RegistrationPageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegistrationPageView()
                .preferredColorScheme(.dark)
        }
    }
}

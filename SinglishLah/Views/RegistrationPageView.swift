//
//  FirebaseAuth.swift
//  SinglishLah
//
//  Created by Merrick Neo on 16/5/22.
//

import SwiftUI

struct RegistrationPageView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            
            if viewModel.signedIn {
                // Change here later to navigate to the HomePage Later
                    TabHomeView()
                }
            else {
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
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

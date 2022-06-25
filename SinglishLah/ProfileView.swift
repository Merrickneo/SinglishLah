//
//  ProfileView.swift
//  SinglishLah
//
//  Created by Ryu Suzuki on 23/6/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var service: SessionServiceImpl

    var body: some View {
        Button(action: {
            service.logout()
        }, label: {
            Text("Sign Out")
                .foregroundColor(Color.blue)
        })
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

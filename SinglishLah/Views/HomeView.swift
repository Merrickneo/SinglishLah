//
//  HomeView.swift
//  SinglishLah
//
//  Created by Ryu Suzuki on 24/5/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct HomeView: View {
    //@EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var service: SessionServiceImpl
    
    @State var progressValue: Float = 0.2
    
    @StateObject
    var viewModel = ReadViewModel()
    
    private let locations = ["Hawker Centre", "Water Park", "MRT Station", "Airport"]
    private let experiences = ["Marina Bay", "Singapore Zoo", "Chinatown", "Kampong Glam"]
    var body: some View {
        VStack {
            ZStack {
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView (showsIndicators: false) {
                    VStack (alignment: .leading) {
                        // ExtView()
                        Text("Welcome Back, \(service.userDetails?.firstName ?? "User")!")
                            .font(.system(size: 28))
                            .padding()
                        
                        HStack {
                            HStack {
                                VStack {
                                    ProgressBar(value: $progressValue).frame(height: 20)
                                    
                                    Text("160XP to Level 11")
                                }.padding()
                            }
                        }
                        
                        if viewModel.value != nil {
                            Text("EXP: " + String(viewModel.value!))
                        } else {
                            Text("Error retrieving EXP")
                        }
                        
                        Button {
                            viewModel.readValue()
                        } label: {
                            Text("Refresh EXP")
                                .foregroundColor(.white)
                                .padding()
                                .background(.blue)
                                .cornerRadius(15)
                        }
                        
                        Text("Singlish Scenarios")
                            .font(.system(size: 24))
                            .padding(.horizontal)
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 4) { index in
                                    ExplorationView(image: Image("lunch_\(index + 1)"), size: 210, caption: locations[index])
                                }
                                .padding(.trailing)
                            }.padding(.leading)
                        }
                        .padding(.bottom)
                        
                        Text("Experience Singapore")
                            .font(.system(size: 24))
                            .padding(.horizontal)
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 4) { index in
                                    ExplorationView(image: Image("experience_\(index + 1)"), size: 180, caption: experiences[index])
                                }
                                .padding(.trailing)
                            }.padding(.leading)
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
    }
    
    func startProgressBar() {
        for _ in 0...80 {
            self.progressValue += 0.015
        }
    }
        
    func resetProgressBar() {
        self.progressValue = 0.0
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(SessionServiceImpl())
        }
    }
}

struct ExtView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "arrowshape.turn.up.backward")
                    .resizable()
                    .frame(width: 42, height: 32)
                    .padding()
                    .cornerRadius(10.0)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 42, height: 42)
                    .padding()
                    .cornerRadius(10.0)
            }
        }
        .padding(.horizontal)
    }
}

struct TagLineView: View {
    var body: some View {
        Text("Welcome Back, User!")
            .font(.system(size: 28))
    }
}

struct ExploreView: View {
    var body: some View {
        Text("Learn More")
            .font(.system(size: 16))
            .foregroundColor(Color.blue)
    }
}

struct TranslateView: View {
    @State private var search: String = ""
    var body: some View {
        VStack {
            Text("Quick Translate")
                .font(.system(size: 16))
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                TextField("enter word/phrase", text: $search)
            }.padding()
                .background(Color.white)
                .cornerRadius(10.0)
        }
    }
}

struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    //.animation()
            }.cornerRadius(45.0)
        }
    }
}

struct ExplorationView: View {
    @State private var isShowing = false
    let image: Image
    let size: CGFloat
    let caption: String
    var body: some View {
        Button(action: {
            isShowing.toggle()
        }) {
            VStack {
                image
                    .resizable()
                    .frame(width: size, height: 200 * (size/210))
                    .cornerRadius(20.0)
                
                Text(caption)
                    .font(.title3)
                    .foregroundColor(.black)
            }
            .frame(width: 210)
            .padding()
            .background(Color.white)
            .cornerRadius(20.0)
        }
        .sheet(isPresented: $isShowing) {
            VStack {
                image
                    .resizable()
                    .frame(height: 300.0)
                    .cornerRadius(10.0)
                HawkerView()
            }
        }
    }
}

struct BottomNavBarItem: View {
    let image: Image
    let action: () -> Void
    var body: some View {
        Button(action: {}, label: {
            image
                .frame(maxWidth: .infinity)
        })
    }
}

struct NewView: View {
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection) {
            Text("Home Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
         
            Text("Bookmark Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "bookmark.circle.fill")
                    Text("Bookmark")
                }
                .tag(1)
         
            Text("Video Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "video.circle.fill")
                    Text("Video")
                }
                .tag(2)
         
            Text("Profile Tab")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(3)
        }
    }
}

struct HawkerView: View {
    var body: some View {
        VStack {
            Text("Hawker Centre")
                .font(.title)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                .padding()
            
            
            Text("A hawker centre or cooked food centre is an open-air complex commonly found in Singapore, offering a variety of affordable meals.")
                .font(.subheadline)
                .padding(.horizontal)
            
            Spacer()
                .frame(height: 15.0)
            
            Text("Commonly Used Phrases:")
                .font(.title2)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                .padding(.leading)
            
            Spacer()
                .frame(height: 10.0)
            
            Text("Tabao - Takeout instead of dining in")
                .font(.subheadline)
                .padding(.leading)
                .frame(maxWidth: .infinity,  alignment: .leading)
            
            
            Text("Chope a table - ‘Reserve’ the table; usually with a packet of tissue ")
                .font(.subheadline)
                .frame(alignment: .leading)
            
            Spacer()
            
        }
    }
}

class ReadViewModel: ObservableObject {
    var ref = Database.database().reference()
    
    @Published
    var value: Int? = nil
    var userID = Auth.auth().currentUser?.uid
    
    func readValue() {
        ref.child("users").child(userID!).child("EXP").observeSingleEvent(of: .value) { snapshot in
            self.value = snapshot.value as? Int ?? 0
        }
    }
    
    func observer() {
        ref.child("users").child(userID!).child("EXP").observe(.value) { snapshot in
            self.value = snapshot.value as? Int ?? 0
        }
    }
}

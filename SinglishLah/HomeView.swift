//
//  HomeView.swift
//  SinglishLah
//
//  Created by Ryu Suzuki on 24/5/22.
//

import SwiftUI

struct HomeView: View {
    @State var progressValue: Float = 0.2
    
    private let locations = ["Hawker Centre", "Water Park", "MRT Station", "Airport"]
    var body: some View {
        VStack {
            ZStack {
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView (showsIndicators: false) {
                    VStack (alignment: .leading) {
                        ExtView()
                        
                        TagLineView()
                            .padding()
                        
                        HStack {
                            HStack {
                                VStack {
                                    ProgressBar(value: $progressValue).frame(height: 20)
                                    
                                    Text("160XP to Level 11")
                                }.padding()
                            }
                        }
                        
                        ExploreView()
                            .padding()
                        
                        TranslateView()
                            .padding()
                        
                        Text("Explore Singapore")
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
                    }
                }
                HStack {
                    BottomNavBarItem(image: Image(systemName: "house")) {}
                    BottomNavBarItem(image: Image(systemName: "magnifyingglass")) {}
                    BottomNavBarItem(image: Image(systemName: "book")) {}
                    BottomNavBarItem(image: Image(systemName: "person")) {}
                }
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
                .frame(maxHeight: .infinity, alignment: .bottom)
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
        HomeView()
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
                Image(systemName: "magnifyingglass")
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
    let image: Image
    let size: CGFloat
    let caption: String
    var body: some View {
        VStack {
            image
                .resizable()
                .frame(width: size, height: 200 * (size/210))
                .cornerRadius(20.0)
            
            Text(caption)
                .font(.title3)
        }
        .frame(width: 210)
        .padding()
        .background(Color.white)
        .cornerRadius(20.0)
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

//
//  QuizView.swift
//  SinglishLah
//
//  Created by Ryu Suzuki on 16/7/22.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct QuizView: View {
    var body: some View {
        MainQuiz()
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}

struct MainQuiz: View {
    @State var show = false
    @State var set = "Round_1"
    
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    
    var body: some View {
        VStack {
            Text("Sentence Builder Game")
                .font(.system(size: 24))
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .padding(.top)
            
            Spacer(minLength: 0)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 35, content: {
                
                ForEach(1...4, id: \.self){index in
                    
                    VStack(spacing: 15){
                        
                        Image("lunch_\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 150)
                        
                        Text("Singlish Quiz")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        Text("LEVEL \(index)")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .onTapGesture(perform: {
                        set = "Round_\(index)"
                        show.toggle()
                    })
                }
            })
            .padding()
            
            Spacer(minLength: 0)
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea())
        .sheet(isPresented: $show, content: {
            QA(correct: $correct, wrong: $wrong)
        })
    }
}

struct QA: View {
    @Binding var correct : Int
    @Binding var wrong : Int
    var body: some View {
        
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
            
            Capsule()
                .fill(Color.gray.opacity(0.7))
                .frame(height: 6)
            
            Capsule()
                .fill(Color.green)
                .frame(width: 100, height: 6)
        })
        .padding()
        
        HStack{
            
            Label(title: { Text(correct == 0 ? "" : "\(correct)")
                .font(.largeTitle)
                .foregroundColor(.black)
            }, icon: {
                Image(systemName: "checkmark")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            })
            
            Spacer()
            
            Label(title: { Text(wrong == 0 ? "" : "\(wrong)")
                .font(.largeTitle)
                .foregroundColor(.black)
            }, icon: {
                Image(systemName: "xmark")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            })
        }
        .padding()
        
        Spacer(minLength: 0)
    }
}

struct Question: Identifiable, Codable {
    var id: String?
    var question : String?
    var optionA: String?
    var optionB: String?
    var optionC: String?
    var answer: String?
    var isSubmitted = false
    var completed = false
    
    enum CodingKeys: String, CodingKey {
        case question
        case optionA = "a"
        case optionB = "b"
        case optionC = "c"
        case answer
    }
}

class QuestionViewModel: ObservableObject {
    @Published var questions : [Question] = []
    
    func getQuestions(set: String) {
        let db = Firestore.firestore()
        db.collection("Round_1").getDocuments { (snap, err) in
            guard let data = snap else{return}
            
            DispatchQueue.main.async {
                self.questions = data.documents.compactMap({ (doc) -> Question? in return try? doc.data(as: Question.self)
                    
                })
            }
        }
    }
}

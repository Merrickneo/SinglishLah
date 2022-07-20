//
//  QuizView.swift
//  SinglishLah
//
//  Created by Ryu Suzuki on 16/7/22.
//

import SwiftUI
import FirebaseFirestore
import Firebase
import FirebaseCore

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
                        
                        Text("Quiz \(index)")
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
            QA(correct: $correct, wrong: $wrong, answered : $answered, set : set)
        })
    }
}

struct QA: View {
    @Binding var correct : Int
    @Binding var wrong : Int
    @Binding var answered : Int
    var set : String
    @StateObject var data = QuestionViewModel()
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        
        ZStack {
            if data.questions.isEmpty {
                ProgressView()
            } else {
                if answered == data.questions.count {
                    VStack(spacing: 25) {
                        Text("Well Done!")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                            
                            Text("\(correct)")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            
                            Image(systemName: "xmark")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            
                            Text("\(wrong)")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            present.wrappedValue.dismiss()
                        }, label: {
                            Text("Home")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color.blue)
                                .cornerRadius(15)
                        })
                    }
                } else {
                    VStack {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                            
                            Capsule()
                                .fill(Color.gray.opacity(0.7))
                                .frame(height: 6)
                            
                            Capsule()
                                .fill(Color.green)
                                .frame(width: progress(), height: 6)
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
                        
                        ZStack {
                            ForEach(
                                data.questions.reversed().indices, id: \.self
                            ){
                                index in
                                
                                QuestionView(question: $data.questions[index], correct: $correct, wrong: $wrong, answered: $answered)
                                    .offset(x: data.questions[index].completed ? 1000 : 0)
                                    .rotationEffect(.init(degrees: data.questions[index].completed ? 10 : 0))
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear(perform: {
            data.getQuestions(set: set)
        })
    }
    
    func progress()->CGFloat {
        let fraction = CGFloat(answered) / CGFloat(data.questions.count)
        let width = UIScreen.main.bounds.width - 30
        return fraction * width
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
    
    @Published var questions = [Question]()
    
    func getQuestions(set: String) {
        
        let db = Firestore.firestore()
        
        db.collection("Questions").addSnapshotListener { (snap, err) in
            guard let documents = snap?.documents else {
                return
            }

            self.questions = documents.compactMap({ (doc) -> Question in
                let data = doc.data()
                let idee = data["id"] as? String ?? ""
                let question = data["question"] as? String ?? ""
                let optionA = data["a"] as? String ?? ""
                let optionB = data["b"] as? String ?? ""
                let optionC = data["c"] as? String ?? ""
                let answer = data["answer"] as? String ?? ""
                return Question(id: idee, question: question, optionA: optionA, optionB: optionB, optionC: optionC, answer: answer)
                    
            })
            
            
            print(self.questions)
        }
    }
}

struct QuestionView: View {
    @Binding var question: Question
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    
    @State var selected = ""
    
    var body: some View {
        VStack(spacing: 22) {
            Text(question.question!)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.top, 25)
            
            Spacer()
            
            Button(action: {selected = question.optionA!}, label: {
                Text(question.optionA!)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                        .stroke(color(option: question.optionA!), lineWidth: 1))
            })
            
            Button(action: {selected = question.optionB!}, label: {
                Text(question.optionB!)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                        .stroke(color(option: question.optionB!), lineWidth: 1))
            })
            
            Button(action: {selected = question.optionC!}, label: {
                Text(question.optionC!)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionC!), lineWidth: 1))
            })
            
            Spacer()
            
            HStack(spacing: 15) {
                Button(action: checkAns, label: {
                    Text("Submit")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                })
                .disabled(question.isSubmitted ? true : false)
                .opacity(question.isSubmitted ? 0.7 : 1)
                
                Button(action: {
                    withAnimation {
                        question.completed.toggle()
                        answered += 1
                    }
                }, label: {
                    Text("Next")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                })
                .disabled(!question.isSubmitted ? true : false)
                .opacity(!question.isSubmitted ? 0.7 : 1)
                
            }
            .padding(.bottom)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
    }
    
    func color(option: String)->Color{
        if option == selected {
            if question.isSubmitted {
                if selected == question.answer! {
                    return Color.green
                } else {
                    return Color.red
                }
            } else {
                return Color.blue
            }
        } else {
            if question.isSubmitted && option != selected {
                if question.answer! == option { return Color.green }
            }
            return Color.gray
        }
    }
    
    func checkAns() {
        if selected == question.answer! {
            correct += 1
        } else {
            wrong += 1
        }
        
        question.isSubmitted.toggle()
    }
}

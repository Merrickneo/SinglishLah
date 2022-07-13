//
//  SignUpView.swift
//  SinglishLah
//
//  Created by Ryu Suzuki on 23/6/22.
//
import SwiftUI
import Foundation
import Combine
import Firebase
import FirebaseDatabase

struct SignUpView: View {
    //@State var email = ""
    //@State var password = ""
    //@State var firstName = ""
    //@State var lastName = ""
    //@EnvironmentObject var viewModel: AppViewModel
    
    @StateObject private var viewModel = RegistrationViewModelImpl(service: RegistrationServiceImpl()
    )
    
    var body: some View {
            
            NavigationView {
                
                VStack(spacing: 32) {
                    
                    VStack(spacing: 16) {
                        
                        InputTextFieldView(text: $viewModel.newUser.email,
                                           placeholder: "Email",
                                           keyboardType: .emailAddress,
                                           systemImage: "envelope")
                        
                        InputPasswordView(password: $viewModel.newUser.password,
                                          placeholder: "Password",
                                          systemImage: "lock")
                        
                        Divider()
                        
                        InputTextFieldView(text: $viewModel.newUser.firstName,
                                           placeholder: "First Name",
                                           keyboardType: .namePhonePad,
                                           systemImage: nil)
                        
                        InputTextFieldView(text: $viewModel.newUser.lastName,
                                           placeholder: "Last Name",
                                           keyboardType: .namePhonePad,
                                           systemImage: nil)
                    }
                    
                    ButtonView(title: "Create Account") {
                        viewModel.create()
                    }
                }
                .padding(.horizontal, 15)
                .navigationTitle("Register")
                //.applyClose()
                .alert(isPresented: $viewModel.hasError,
                       content: {
                        
                        if case .failed(let error) = viewModel.state {
                            return Alert(
                                title: Text("Error"),
                                message: Text(error.localizedDescription))
                        } else {
                            return Alert(
                                title: Text("Error"),
                                message: Text("Something went wrong"))
                        }
                })
            }
        }
    }

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

enum RegistrationState {
    case successfullyRegistered
    case failed(error: Error)
    case na
}

struct RegistrationCredentials {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var EXP: Int
}

protocol RegistrationService {
    func register(with credentials: RegistrationCredentials) -> AnyPublisher<Void, Error>
}

enum RegistrationKeys: String {
    case firstName
    case lastName
    case EXP
}

final class RegistrationServiceImpl: RegistrationService {
    
    func register(with credentials: RegistrationCredentials) -> AnyPublisher<Void, Error> {
        
        Deferred {

            Future { promise in
                
                Auth.auth().createUser(withEmail: credentials.email,
                                       password: credentials.password) { res, error in
                    
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        
                        if let uid = res?.user.uid {
                            
                            let values = [RegistrationKeys.firstName.rawValue: credentials.firstName,
                                          RegistrationKeys.lastName.rawValue: credentials.lastName,
                                          RegistrationKeys.EXP.rawValue: credentials.EXP] as [String : Any]
                            
                            Database
                                .database(url: "https://singlishlah-1652625809497-default-rtdb.asia-southeast1.firebasedatabase.app")
                                .reference()
                                .child("users")
                                .child(uid)
                                .updateChildValues(values) { error, ref in
                                    
                                    if let err = error {
                                        promise(.failure(err))
                                    } else {
                                        promise(.success(()))
                                    }
                                }
                        }
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}

protocol RegistrationViewModel {
    func create()
    var service: RegistrationService { get }
    var state: RegistrationState { get }
    var hasError: Bool { get }
    var newUser: RegistrationCredentials { get }
    init(service: RegistrationService)
}

final class RegistrationViewModelImpl: ObservableObject, RegistrationViewModel {
    
    let service: RegistrationService
    @Published var state: RegistrationState = .na
    @Published var newUser = RegistrationCredentials(email: "",
                                                     password: "",
                                                     firstName: "",
                                                     lastName: "",
                                                     EXP: 0)
    @Published var hasError: Bool = false

    private var subscriptions = Set<AnyCancellable>()
    
    init(service: RegistrationService) {
        self.service = service
        setupErrorSubscription()
    }
    
    func create() {
                
        service
            .register(with: newUser)
            .sink { [weak self] res in
            
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfullyRegistered
            }
            .store(in: &subscriptions)
    }
}

private extension RegistrationViewModelImpl {
    
    func setupErrorSubscription() {
        $state
            .map { state -> Bool in
                switch state {
                case .successfullyRegistered,
                     .na:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}

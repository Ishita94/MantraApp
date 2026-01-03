//
//  LoginForm.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-22.
//

import SwiftUI
import FirebaseAuth

struct LoginForm: View {
    
    @Binding var formShowing: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isPasswordVisible = false
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    HStack {
                        Group {
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
                            }
                        }
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.secondary)
                        }
                        .accessibilityLabel(
                            isPasswordVisible ? "Hide password" : "Show password"
                        )
                    }
                }
                
                if errorMessage != nil {
                    Section {
                        Text(errorMessage!)
                    }
                }
                
                Button(action: {
                    
                    // Perform login
                    signIn()
                    
                }, label: {
                    HStack {
                        Spacer()
                        Text("Sign in")
                        Spacer()
                    }
                })
            }
            .navigationBarTitle("Sign In")
        }
        
    }
    
    func mapAuthError(_ error: Error) -> LoginError {
        let nsError = error as NSError
        
        guard let code = AuthErrorCode.Code(rawValue: nsError.code) else {
            return .unknown
        }
        
        switch code {
        case .invalidEmail:
            return .invalidEmail
        case .wrongPassword, .invalidCredential, .internalError:
            return .wrongPasswordorEmail
        case .userNotFound:
            return .userNotFound
        case .networkError:
            return .networkIssue
        default:
            return .unknown
        }
    }
    
    func signIn() {
        print("Sign in button tapped")
        print("Email: \(email)")
        print("Password length: \(password.count)")
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                let loginError = mapAuthError(error)
                DispatchQueue.main.async {
                    errorMessage = loginError.localizedDescription
                }
                return
            }
            if let user = result?.user {
                DispatchQueue.main.async {
                    formShowing = false
                }
            }
            else
            {
                DispatchQueue.main.async {
                    errorMessage = "Sign in failed."
                }
                return
            }
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm(formShowing: Binding.constant(true))
    }
}

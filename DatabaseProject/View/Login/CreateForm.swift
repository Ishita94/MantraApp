//
//  CreateForm.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-22.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct CreateForm: View {
    
    @Binding var formShowing: Bool
    
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    
    @State private var errorMessage: String?
    @EnvironmentObject var eventViewModel : EventsViewModel

    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section {
                    TextField("Email", text: $email)
                    TextField("Name", text: $name)
                    SecureField("Password", text: $password)
                }
                
                if errorMessage != nil {
                    Section {
                        Text(errorMessage!)
                    }
                }
                
                Button(action: {
                    
                    // Create account
                    createAccount()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Create Account")
                        Spacer()
                    }
                })
            }
            .navigationBarTitle("Create an Account")
            
        }
        
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                if error == nil {
                    
                    // Save the first name
                    saveFirstName()
                    
                    // Dismiss the form
                    formShowing = false
                }
                else {
                    errorMessage = error!.localizedDescription
                }
            }
            
        }
    }
    
    func saveFirstName() {
        
        if let currentUser = Auth.auth().currentUser {
        
            let cleansedFirstName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                
            let db = Firestore.firestore()
            let path = db.collection("users").document(currentUser.uid)
            path.setData(["name":cleansedFirstName, "createDate": Date.now]) { error in
                
                if error == nil {
                    // Saved
                    for event in eventViewModel.definedEventList{
                        eventViewModel.saveEvent(event: event)
                    }
                }
                else {
                    // Error
                }
            }
        }
        
    }
}

struct CreateForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateForm(formShowing: Binding.constant(true))
    }
}

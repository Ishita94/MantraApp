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
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
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
        try? Auth.auth().signOut()
        
        print("Current user after signout:", Auth.auth().currentUser?.uid ?? "nil")

        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = error.localizedDescription
                    return
                }
                // Save the first name
                if let user = result?.user {
                    print("Created user UID:", user.uid)

                    // CHECK PROVIDERS HERE
                            let providers = user.providerData.map { $0.providerID }
                            print("Providers after create:", providers)

                            if providers.contains("phone") {
                                print("ERROR: Phone provider should not be present")
                            }

                            if providers.contains("password") {
                                print("✅ Email/password user created correctly")
                            }
                    
                    saveFirstName(for : user)
                    // Dismiss the form
                    formShowing = false
                }
                else{
                    errorMessage = "User creation failed."
                    return
                }
            }
        }
        
    }
    
    func saveFirstName(for user: User) {
        let cleansedFirstName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let db = Firestore.firestore()
        let path = db.collection("users").document(user.uid)
        path.setData(["name":cleansedFirstName, "createDate": Date.now]) { error in
            
            //                if error == nil {
            //                    // Saved
            //                    for event in eventViewModel.definedEventList{
            //                        eventViewModel.saveEvent(event: event)
            //                    }
            //                }
            //                else {
            //                    // Error
            //                }
        }
    }
    
    //}
}

struct CreateForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateForm(formShowing: Binding.constant(true))
    }
}

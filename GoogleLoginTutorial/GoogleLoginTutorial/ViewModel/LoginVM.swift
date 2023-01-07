//
//  LoginVM.swift
//  GoogleLoginTutorial
//
//  Created by Kyungsoo Lee on 2023/01/08.
//

import SwiftUI
import Firebase
import GoogleSignIn

class SignupViewModel: ObservableObject {
    @Published var isLogin: Bool = false
    func signUpWithGoogle() {
        // get app client id
        let clienId = FirebaseApp.app()?.options.clientID else { return }
        
        // get configuration
        let config = GIDConfiguration(clientID: clienId)
        
        // SignIn
        GIDSignIn.sharedInstance.signIn(with: config, presenting: )
    }
}

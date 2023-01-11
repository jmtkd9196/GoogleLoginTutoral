//
//  ContentView.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/12.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct ContentView: View {
    @StateObject var signInVM: SignInVM = .init()
    
    var body: some View {
        VStack {
            GoogleSignInButton(action: handleSignInButton)
        }
        .padding()
    }
    
    
    func handleSignInButton() {
      GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootController()) { signInResult, error in
          guard let result = signInResult else {
            // Inspect error
            return
          }
          // Test code
          print("Success Google!")
          print(result.user.idToken?.tokenString)
          print(result.user.profile?.name)
          print(result.user.profile?.email)
          
          // If sign in succeeded, display the app's main content View.
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

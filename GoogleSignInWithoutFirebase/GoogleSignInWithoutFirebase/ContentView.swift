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
    
    //test
    @State private var accessToken : String? = ""
    @State private var refreshToken : String? = ""
    @State private var email : String? = ""
    @State private var name : String? = ""
    @State private var imageURL : URL?
    @State private var message: String = "API 호출 중..."
    //test
    var body: some View {
        VStack {
            GoogleSignInButton(action: handleSignInButton)
            
            
            
            // test code
                
            
            let url = URL(string: "http://hwgapp.com/join")
            Link(destination: url!, label: {
                HStack {
                    Spacer()
                    Text("직접 링크 넣기")
                    Spacer()
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            })
            
            // test code

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
//          print(result.user.idToken?.tokenString)
//          print("[RefreshToken] : \(result.user.refreshToken.tokenString)")
//          print(result.user.profile?.name)
//          print(result.user.profile?.email)
//          print(result.user.profile?.givenName)
//          print(result.user.profile?.hasImage)
//          print("[imageURL] : \(result.user.profile?.imageURL(withDimension: 320))")
          
          accessToken = result.user.idToken?.tokenString
          refreshToken = result.user.refreshToken.tokenString
          imageURL = result.user.profile?.imageURL(withDimension: 320)
          name = result.user.profile?.name
          email = result.user.profile?.email
          print(accessToken)
          print(refreshToken)
          print(name)
          print(email)
          print(imageURL)
          
          request("http://hwgapp.com/join", "POST", ["key":"hello!"]) { (success, data) in
              self.message = data as! String
              
          }
          
          
          
          
          // If sign in succeeded, display the app's main content View.
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

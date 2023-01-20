//
//  SignInVM.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/12.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

class SignInVM: ObservableObject {
    //test
//    @State private var accessToken : String? = ""
//    @State private var refreshToken : String? = ""
//    @State private var email : String? = ""
//    @State private var name : String? = ""
//    @State private var imageURL : URL?
    @State private var message: String = "API 호출 중..."
    @StateObject var userAPI: UserAPI = .init()
    var user: User = .init(googleSignResponse: User.GoogleSignInInfo(), serverSignResponse: User.HwgSignInInfo())
    
    //test
    // 연동을 시도 했을때 불러오는 메소드
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInError.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        // 사용자 정보 가져오기
        if let userId = user.userID,                  // For client-side use only!
           let idToken = user.idToken, // Safe to send to the server
           let fullName = user.profile?.name,
           let givenName = user.profile?.givenName,
           let familyName = user.profile?.familyName,
           let email = user.profile?.email {
            
            print("Token : \(idToken)")
            print("User ID : \(userId)")
            print("User Email : \(email)")
            print("User Name : \((fullName))")
            
        } else {
            print("Error : User Data Not Found")
        }
    }
    
    // 구글 로그인 연동 해제했을때 불러오는 메소드
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Disconnect")
    }
    
    func handleSignInButton() -> Void {
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
          
         
          
          
          
          
          guard let name = result.user.profile?.name else { return }
          guard let email = result.user.profile?.email else { return }
          guard let imageURL = result.user.profile?.imageURL(withDimension: 320)?.absoluteString else { return }
          guard let name = result.user.idToken?.tokenString else { return }
          let refreshToken = result.user.refreshToken.tokenString
          
          var response = Response(name: name, email: email, imageURL: imageURL, accessToken: name, refreshToken: refreshToken)
          
          self.user.googleSignResponse.setInfo(response)
          
          
          
//
//          print(user.accessToken)
//          print(user.refreshToken)
//          print(user.name)
//          print(user.email)
//          print(user.imageURL)
          
          
          self.userAPI.request("POST", [String(self.user.googleSignResponse.accessToken), String(self.user.googleSignResponse.refreshToken)], ["authProvider" : "GOOGLE", "email" : self.user.googleSignResponse.email, "name" : self.user.googleSignResponse.name, "image" : self.user.googleSignResponse.imageURL]) { (success, data) in
              self.message = data as! String
              
          }
          
          
          
          
          // If sign in succeeded, display the app's main content View.
        }
    }
}

extension UIApplication {
    // Root Controller
    func rootController() -> UIViewController {
        guard let window = connectedScenes.first as? UIWindowScene else { return .init() }
        guard let viewController = window.windows.last?.rootViewController else { return .init() }
        
        return viewController
    }
}

extension SignInVM {
    struct Response: Codable {
        let name: String
        let email: String
        let imageURL: String
        let accessToken: String
        let refreshToken: String
    }
}

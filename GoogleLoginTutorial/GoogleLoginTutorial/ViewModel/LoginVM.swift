//
//  LoginVM.swift
//  GoogleLoginTutorial
//
//  Created by Kyungsoo Lee on 2023/01/08.
//

import SwiftUI
import Firebase
import GoogleSignIn
import GoogleSignInSwift

class LoginVM: ObservableObject {
    // MARK: View Properties
    //앱에 logStatus 저장
    @AppStorage("log_status") var logStatus: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: Logging Google user into Firebase
    func logGoogleUser(user: GIDGoogleUser) {
        Task {
            do {
                // 꼭 tokenString을 써서 string값으로 반환해줘야 한다. 그래야 credential에 넣을 때 인자의 type이 맞는다.
                guard let idToken = user.idToken?.tokenString else { return }
                let accessToken = user.accessToken.tokenString
                let credential = OAuthProvider.credential(withProviderID: idToken, accessToken: accessToken)
                
                try await Auth.auth().signIn(with: credential)
                
                print("Success Google!")
                await MainActor.run(body: {
                    withAnimation(.easeInOut) {
                        logStatus = true
                    }
                })
            } catch {
                await handleError(error: error)
            }
        }
    }
    
    func handleError(error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
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

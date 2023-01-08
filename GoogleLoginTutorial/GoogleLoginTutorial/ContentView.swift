//
//  ContentView.swift
//  GoogleLoginTutorial
//
//  Created by Kyungsoo Lee on 2023/01/07.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct ContentView: View {
    @StateObject var loginModel: LoginVM = .init()
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                // MARK: Custom Google Sign in Button
                CustomButton(isGoogle: true)
                    .overlay {
                        // MARK: We Have Native Google Sign in Button
                        // It's Simple to Integrate Now
                        if let clientId = FirebaseApp.app()?.options.clientID {
                        GoogleSignInButton {
                            GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootController()) { user, error in
                                if let error = error {
                                    print(error.localizedDescription)
                                    return
                                }
                            }
                            
                            // MARK: Logging Google User into Firebase
                                
                            }
                        }
                    }
                    .clipped()
            }
            .padding()
            .frame(maxWidth: .infinity)
            
        }
        
    }
    
    @ViewBuilder
    func CustomButton(isGoogle: Bool = false) -> some View {
        HStack {
            Group {
                if isGoogle {
                    Image("Google")
                        .resizable()
                        .renderingMode(.template)
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .frame(height: 45)
            
            Text("Google Sign in")
                .font(.callout)
                .lineLimit(1)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 15)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.black)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

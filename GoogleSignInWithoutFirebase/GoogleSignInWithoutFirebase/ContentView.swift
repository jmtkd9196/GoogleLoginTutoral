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
    @StateObject var userAPI: UserAPI = .init()
    @StateObject var signVM: SignInVM = .init()
    
    var body: some View {
        VStack {
            GoogleSignInButton(action: signVM.handleSignInButton)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
    
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        if logStatus {
            // MARK: YOUR HOME VIEW
            DemoHome()
        } else {
            LoginView()
        }
    }
    
    @ViewBuilder
    func DemoHome() -> some View {
        NavigationStack {
            Text("Logged In")
                .navigationTitle("Multi-Login")
                .toolbar {
                    ToolbarItem {
                        Button("Logout") {
                            try? Auth.auth().signOut()
                            GIDSignIn.sharedInstance.signOut()
                            withAnimation(.easeInOut) {
                                logStatus = false
                            }
                        }
                    }
                }
        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

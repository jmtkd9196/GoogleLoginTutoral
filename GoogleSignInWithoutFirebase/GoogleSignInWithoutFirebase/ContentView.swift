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
    
    
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

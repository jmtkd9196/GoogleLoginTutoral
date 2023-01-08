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
        VStack {
            
            
        }
        
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

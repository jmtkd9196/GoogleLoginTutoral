//
//  GoogleSignInWithoutFirebaseApp.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/12.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@main
struct GoogleSignInWithoutFirebaseApp: App {
    // @UIApplicationDelegateAdaptor 프로퍼티 래퍼를 사용하여 App 구조체 내부에서 사용이 불가능한 기능을 사용.
    // AppDelegate에서 패키지 초기화
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
}

//
//  GoogleLoginTutorialApp.swift
//  GoogleLoginTutorial
//
//  Created by Kyungsoo Lee on 2023/01/07.
//

import SwiftUI
import Firebase
import GoogleSignIn


@main
struct GoogleLoginTutorialApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let clientID = FirebaseApp.app()?.options.clientID
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)}
        }
    }
}



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
        }
    }
}

// MARK: Initializing Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    // MARK: Phone Auth Needs to Initialize Remote Notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        return .noData
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
    }
}

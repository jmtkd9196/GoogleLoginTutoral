//
//  Application.swift
//  GoogleLoginTutorial
//
//  Created by Kyungsoo Lee on 2023/01/08.
//

import SwiftUI

final class ApplicationUtility {
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}

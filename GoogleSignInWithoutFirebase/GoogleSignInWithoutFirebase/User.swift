//
//  User.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/17.
//

import Foundation

struct User: Codable {
    var googleSignResponse: GoogleSignInInfo
    var serverSignResponse: HwgSignInInfo

}

extension User {
    struct GoogleSignInInfo: Codable {
        var name: String
        var email: String
        var imageURL: String
        var accessToken: String
        var refreshToken: String
        
        init() {
            name = ""
            email = ""
            imageURL = ""
            accessToken = ""
            refreshToken = ""
        }
        
        mutating func setInfo(_ GoogleSignInInfo: SignInVM.Response) {
            name = GoogleSignInInfo.name
            email = GoogleSignInInfo.email
            imageURL = GoogleSignInInfo.imageURL
            accessToken = GoogleSignInInfo.accessToken
            refreshToken = GoogleSignInInfo.refreshToken
        }
    }
    
    struct HwgSignInInfo: Codable {
        var jwtAccessToken: String
        var jwtRefreshToken: String
        var userId: String
        
        init() {
            jwtAccessToken = ""
            jwtRefreshToken = ""
            userId = ""
        }
    }
    
   
}




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
        
        mutating func setInfo(_ googleSignInInfo: SignInVM.UserData) {
            name = googleSignInInfo.name
            email = googleSignInInfo.email
            imageURL = googleSignInInfo.imageURL
            accessToken = googleSignInInfo.accessToken
            refreshToken = googleSignInInfo.refreshToken
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
        
//        mutating func setInfo(_ serverSignInInfo: UserAPI.UserData) {
//            
//        }
    }
    
   
}




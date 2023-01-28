//
//  User.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/17.
//

import Foundation

struct User: Codable {
    var googleSignResponse: GoogleAPIData?
    var serverSignResponse: UserAPIData?

}

extension User {
    struct GoogleAPIData: Codable {
        var name: String
        var email: String
        var imageURL: String
        var accessToken: String
        var refreshToken: String
        
//        init() {
//            name = ""
//            email = ""
//            imageURL = ""
//            accessToken = ""
//            refreshToken = ""
//        }
        
        mutating func setInfo(_ googleSignInInfo: GoogleAPIViewModel.GoogleAPIData) {
            name = googleSignInInfo.name
            email = googleSignInInfo.email
            imageURL = googleSignInInfo.imageURL
            accessToken = googleSignInInfo.accessToken
            refreshToken = googleSignInInfo.refreshToken
        }
    }
    
    struct UserAPIData: Codable {
        var jwtAccessToken: String
        var jwtRefreshToken: String
        var userId: String
//
//        init() {
//            jwtAccessToken = ""
//            jwtRefreshToken = ""
//            userId = ""
//        }
        
//        mutating func setInfo(_ serverSignInInfo: UserAPI.UserData) {
//            
//        }
    }
    
   
}




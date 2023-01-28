//
//  UserAPI.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/17.
//

import SwiftUI

fileprivate enum HereWeGoAPI {
    static let scheme = "http"
    static let host = "hwgapp.com"
    
    enum Path: String {
        case join = "/v1/join"
    }
    
}

// Codable을 통해 JSON 객체를 Dictionary 타입으로 만들 수 있게 되었다.
struct Response: Codable {
    let success: Bool
    let result: String
    let message: String
}

class UserAPI: ObservableObject {
    @Published var signInVM = SignInVM()
    
    
    // Body가 없는 요청
    func requestGet(completionHandler: @escaping (Bool, Any) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPI.scheme
        urlComponents.host = HereWeGoAPI.host
        urlComponents.path = HereWeGoAPI.Path.join.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }

        //        guard let url = URL(string: url) else {
        //            print("Error: cannot create URL")
        //            return
        //        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            guard let output = try? JSONDecoder().decode(Response.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }

            completionHandler(true, output.result)
        }.resume()
    }
    
    // Body가 있는 요청
    
    // Header와 Body 파라미터 나눠서 작성하기(아직 안고침)
    func requestPost(method: String, userData: [String: Any], completionHandler: @escaping (Bool, Any) -> Void) {
        //    let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])
        //    let json = try! JSONSerialization.data(withJSONObject: param)
        //    print(json)
        

        
        // parameter(= body)에 설정할 자료들 data -> json으로 변환
        //    do {
        let json = try! JSONSerialization.data(withJSONObject: userData, options: [])
        print("###########################")
        print(String(data: json, encoding: .utf8))
        // 결과 :: Optional("{\"name\":\"demnodey\",\"part\":\"development\"}")
        //    } catch {
        //        print(error.localizedDescription)
        //    }
        
        // 1. url Component 설정
        
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPI.scheme
        urlComponents.host = HereWeGoAPI.host
        urlComponents.path = HereWeGoAPI.Path.join.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        // 이 방식으로도 url을 생성 가능하다. -> 두 차이점이 무엇인지??
        // urlComponent는 url의 각 영역(scheme, host 등)을 따로 property로써 설정할 수 있지만
        // URL은 String 형태의 url을 URL자료형으로 타입 캐스팅 하는 것이다.
        //        guard let url = URL(string: url) else {
        //            print("Error: cannot create URL")
        //            return
        //        }
        
        
        // 2. url Request 설정 (Header같은 것 설정)
        var urlRequest = URLRequest(url: url)
        print("[AccessToken] : \(userData["accessToken"])")
        print("[RefreshToken] : \(userData["refreshToken"])")
        urlRequest.httpMethod = method
        urlRequest.setValue(userData["accessToken"] as! String, forHTTPHeaderField: "Access-Token")
        urlRequest.setValue(userData["refreshToken"] as! String, forHTTPHeaderField: "Refresh-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = json
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            let jsonStr = String(decoding: data, as: UTF8.self)
            print("[data] : \(jsonStr)")
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            print("[response] : \(response)")
            //        guard let output = try? JSONDecoder().decode(Response.self, from: data) else {
            //            print("Error: JSON Data Parsing failed")
            //            return
            //        }
            //        print("[output] : \(output)")
            //
            //        //함수가 모두 종료 시 실행되는 핸들러
            //        completionHandler(true, output.result)
            
//            var userData = UserData(jwtAccessToken: jsonStr["jwtToken"], jwtRefreshToken: jsonStr["jwtRefreshToken"], userId: jsonStr["userId"])
            
//            signInVM.user.serverSignResponse.setInfo(UserData)
        }.resume()
    }
    
    /* 메소드별 동작 분리 */
    func request(_ method: String, _ userData: [String: Any], completionHandler: @escaping (Bool, Any) -> Void) {
        if method == "GET" {
//            requestGet { (success, data) in
//                completionHandler(success, data)
//            }
        }
        else {
            requestPost(method: method, userData: userData) { (success, data) in
                completionHandler(success, data)
            }
        }
    }
    
}


extension UserAPI {
    struct GoogleData: Codable {
        let name: String
        let email: String
        let imageURL: String
        let accessToken: String
        let refreshToken: String
    }
    struct ServerData {
        let jwtAccessToken: String
        let jwtRefreshToken: String
        let userId: String
    }
}

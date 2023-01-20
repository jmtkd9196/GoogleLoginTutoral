//
//  UsersAPI.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/17.
//

import SwiftUI

// Codable을 통해 JSON 객체를 Dictionary 타입으로 만들 수 있게 되었다.
struct Response: Codable {
    let success: Bool
    let result: String
    let message: String
}

// Body가 없는 요청
func requestGet(url: String, completionHandler: @escaping (Bool, Any) -> Void) {
    guard let url = URL(string: url) else {
        print("Error: cannot create URL")
        return
    }
    
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
func requestPost(url: String, method: String, testToken: [String], param: [String: Any], completionHandler: @escaping (Bool, Any) -> Void) {
//    let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])
//    let json = try! JSONSerialization.data(withJSONObject: param)
//    print(json)
    

//    do {
        let json = try! JSONSerialization.data(withJSONObject: param, options: [])
        print("###########################")
        print(String(data: json, encoding: .utf8))
        // 결과 :: Optional("{\"name\":\"demnodey\",\"part\":\"development\"}")
//    } catch {
//        print(error.localizedDescription)
//    }

    
    guard let url = URL(string: url) else {
        print("Error: cannot create URL")
        return
    }
    
    print(testToken)
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.setValue(testToken[0] as! String, forHTTPHeaderField: "Access-Token")
    request.setValue(testToken[1] as! String, forHTTPHeaderField: "Refresh-Token")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = json
    
    print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\(url)")
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
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
        print(jsonStr)
        guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        print("[response] : \(response)")
        guard let output = try? JSONDecoder().decode(Response.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }
        print("[output] : \(output)")
        
        completionHandler(true, output.result)
    }.resume()
}

/* 메소드별 동작 분리 */
func request(_ url: String, _ method: String, _ testToken: [String], _ param: [String: Any]? = nil, completionHandler: @escaping (Bool, Any) -> Void) {
    if method == "GET" {
        requestGet(url: url) { (success, data) in
            completionHandler(success, data)
        }
    }
    else {
        requestPost(url: url, method: method, testToken: testToken, param: param!) { (success, data) in
            completionHandler(success, data)
        }
    }
}



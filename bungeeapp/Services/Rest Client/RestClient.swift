//
//  RestClient.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 4.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation
import Alamofire

enum AccountAPI {
    case login(username: String, password: String)
    case register(username: String, password: String)
}

class RestClient {
    private static let BASE_URL = "http://64.227.118.33:8080/api"
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()
    
    static func login(request: LoginRequest,
                      result: @escaping (_ result: AFDataResponse<LoginResponse>) -> Void) {
        postMethod(endpoint: "/accounts/login",
                   data: AnyEncodable(LoginRequest(username: request.username, password: request.password))) {
            (data: AFDataResponse<LoginResponse>) in
            result(data)
        }
    }
    
    static func register(request: RegisterRequest,
                         result: @escaping (_ result: AFDataResponse<RegisterResponse>) -> Void) {
        postMethod(endpoint: "/accounts/sign-up", data: AnyEncodable(RegisterRequest(username: request.username, password: request.password))) {
            (data: AFDataResponse<RegisterResponse>) in
            result(data)
        }
    }
    
    static func getFeed(token: String,
                        result: @escaping (_ result: AFDataResponse<FeedResponse>) -> Void) {
        getMethod(endpoint: "/profiles/feed", token: token) {
            (data: AFDataResponse<FeedResponse>) in
            result(data)
        }
    }
    
    private static func postMethod<T: Decodable>(endpoint: String,
                                                 data: AnyEncodable?,
                                                 token: String? = String(),
                                                 result: @escaping (_ result: AFDataResponse<T>) -> Void) {
        let jsonData = try! encoder.encode(data)
        let urlString = "\(BASE_URL)\(endpoint)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpBody = jsonData
        request.httpMethod = HTTPMethod.post.rawValue
        if !token!.isEmpty {
            request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseDecodable(decoder: decoder, completionHandler: { (response: AFDataResponse<T>) in
            print(response)
            switch response.result {
            case .success:
                result(response)
            case .failure:
                print("Failed to execute request.")
            }
        })
    }
    
    private static func getMethod<T: Decodable>(endpoint: String,
                                                token: String? = nil,
                                                result: @escaping (_ result: AFDataResponse<T>) -> Void) {
        let urlString = "\(BASE_URL)\(endpoint)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        AF.request(request).responseDecodable(decoder: decoder, completionHandler: { (response: AFDataResponse<T>) in
            switch response.result {
            case .success:
                result(response)
            case .failure:
                print(token!)
                print("Failed to execute request.")
            }
        })
    }
}

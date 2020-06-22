//
//  API.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 6.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation
import Alamofire

class API {
    private static var token: String?
    
    public static func login(username: String,
                             password: String,
                             result: @escaping (_ result: LoginResult) -> ()){

        let request = LoginRequest(username: username, password: password)
        _ = RestClient.login(request: request) { (data: AFDataResponse<LoginResponse>) in
            if(data.value?.type == "PASSWORD_FAIL") {
                result(LoginResult(type: LoginResultType.PASSWORD_FAIL))
            }
            if(data.value?.type == "USER_NOT_EXIST") {
                result(LoginResult(type: LoginResultType.USER_NOT_EXIST))
            }
            if(data.value?.type == "SUCCESS") {
                token = data.value?.token
                result(LoginResult(token: (data.value?.token)!, type: LoginResultType.SUCCESS))
            }
        }
    }
    
    public static func register(username: String,
                                password: String,
                                result: @escaping (_ result: RegisterResult) -> ()) {
        let request = RegisterRequest(username: username, password: password)
        _ = RestClient.register(request: request) { (data: AFDataResponse<RegisterResponse>) in
            
            if(data.value?.type == "FAILED") {
                result(RegisterResult(type: RegisterResultType.FAILED))
            }
            if(data.value?.type == "USERNAME_EXISTS") {
                result(RegisterResult(type: RegisterResultType.USERNAME_EXISTS))
            }
            if(data.value?.type == "PASSWORD_INSECURE") {
                result(RegisterResult(type: RegisterResultType.PASSWORD_INSECURE))
            }
            
            if(data.value?.type == "SUCCESS") {
                result(RegisterResult(type: RegisterResultType.SUCCESS))
            }
        }
    }
    
    public static func getFeed(result: @escaping (_ result: FeedResult) -> ()) {
        RestClient.getFeed(token: UserDefaults.standard.value(forKey: "userToken") as! String) { (data: AFDataResponse<FeedResponse>) in
            print(data)
            result(FeedResult(posts: (data.value?.posts)!))
        }
    }
}

//
//  LoginViewModel.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 7.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    let willChange = PassthroughSubject<Void, Never>()
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    var client: API
    
    init(api: API) {
        self.client = api
    }
    
    var isLoggedIn: Bool = false {
        willSet {
            DispatchQueue.main.async {
                self.willChange.send()
            }
        }
    }
}

extension LoginViewModel {
    func login(_ result: @escaping (_ result: Bool) -> ()) {
        API.login(username: self.username, password: self.password) {
            (response: LoginResult) in
            
            if(response.type == LoginResultType.SUCCESS) {
                SessionHelper.setCurrentLoginToken(response.token!)
                result(true)
            } 
        }
    }
}

//
//  LoginResult.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 3.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation

class LoginResult {
    internal init(type: LoginResultType) {
        self.type = type
    }
    
    var type: LoginResultType;
}

enum LoginResultType {
    case SUCCESS
    case FAIL
    case PASSWORD_FAIL
    case USER_NOT_EXIST
}

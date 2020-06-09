//
//  LoginResult.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 3.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation

class LoginResult {
    internal init(token: String? = nil, type: LoginResultType) {
        self.token = token
        self.type = type
    }

    var token: String?;
    var type: LoginResultType;
}

enum LoginResultType {
    case SUCCESS
    case FAIL
    case PASSWORD_FAIL
    case USER_NOT_EXIST
}

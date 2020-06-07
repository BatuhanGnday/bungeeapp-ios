//
//  RegisterResult.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 6.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation

class RegisterResult {
    internal init(type: RegisterResultType) {
        self.type = type
    }
    
    var type: RegisterResultType;
    
    public func getType() -> RegisterResultType {
        return self.type
    }
    
}

enum RegisterResultType {
    case SUCCESS
    case USERNAME_EXISTS
    case PASSWORD_INSECURE
    case FAILED
}

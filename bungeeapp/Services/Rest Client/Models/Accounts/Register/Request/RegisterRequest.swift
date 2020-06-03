//
//  RegisterRequest.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 3.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation

struct RegisterRequest: Encodable {
    var username: String
    var password: String
    
}

//
//  LoginResponse.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 3.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation

struct LoginResponse: Decodable {
    var token: String? = nil
    var type: String
}

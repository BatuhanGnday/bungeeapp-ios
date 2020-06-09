//
//  SessionHelper.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 9.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation

class SessionHelper {
    static func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.object(forKey: "userToken") != nil
    }

    static func logout() {
        UserDefaults.standard.set(nil, forKey: "userToken")
    }

    static func setCurrentLoginToken (_ token: String) {
        UserDefaults.standard.set(token, forKey: "userToken")
    }
}

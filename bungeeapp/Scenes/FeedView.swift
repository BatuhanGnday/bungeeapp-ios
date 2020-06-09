//
//  FeedView.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 7.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import SwiftUI

struct FeedView: View {
    @State var loggedOut: Bool = false
    var body: some View {
        Button(action: {
            SessionHelper.logout()
            self.loggedOut = true
        }) {
            Text("Logout")
        }.navigate(to: LoginView(), when: $loggedOut)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

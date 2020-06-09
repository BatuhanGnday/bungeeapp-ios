//
//  ContentView.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 3.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ViewBuilder
    var body: some View {
        
        if (SessionHelper.isUserLoggedIn()) {
            FeedView()
        } else {
            LoginView()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

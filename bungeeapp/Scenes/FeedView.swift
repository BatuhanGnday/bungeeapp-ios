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
    
    @ObservedObject var feedVM = FeedViewModel(api: API())

    var body: some View {
        VStack {
            
            Button(action: {
                /*API.getFeed() {
                    FeedResult in
                    print(FeedResult.getPosts())
                }*/
                self.feedVM.getFeed()
            }) {
                Text("feed")
            }
            
            Button(action: {
                SessionHelper.logout()
                self.loggedOut = true
            }) {
                Text("Logout")
            }.navigate(to: LoginView(), when: $loggedOut)
            
            ScrollView {
                VStack {
                    ForEach(feedVM.feed.posts ?? [] /* sil mq */, id: \.self) { vm in
                        Text(vm.avatarUUID!)
                    }
                }
            }
            
            

            
        }
    }

}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

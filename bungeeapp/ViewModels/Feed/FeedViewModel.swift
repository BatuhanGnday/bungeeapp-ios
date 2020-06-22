//
//  FeedViewModel.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 13.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class FeedViewModel: ObservableObject {
    // let willChange = PassthroughSubject<Void, Never>()
    var client: API
    @Published var feed: FeedResult = FeedResult(posts: [])
    
    init(api: API) {
        self.client = api
    }
}

extension FeedViewModel {
    func getFeed() {
        API.getFeed() {
            (feed: FeedResult) in
            self.feed = feed

        }
    }
}

//
//  ActionBar.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 10.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import SwiftUI

struct ActionBar: View {
    var body: some View {
        HStack {
            Button(action: {
                
            }){
                Image(systemName: "heart.fill").foregroundColor(Color.pink)
            }.padding()
            
            Text("123")
            
            Button(action: {
                
            }){
                Image(systemName: "star.fill").foregroundColor(Color.yellow)
            }.padding()
            Text("123")
            
        }
    }
}

struct ActionBar_Previews: PreviewProvider {
    static var previews: some View {
        ActionBar()
    }
}

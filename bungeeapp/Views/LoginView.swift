//
//  LoginView.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 6.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showingRegister: Bool = false
    @State private var loggedIn: Bool = false
    
    var body: some View {
        VStack() {
          Text("Bungee | Login")
            .font(.largeTitle)
            .foregroundColor(Color.black)
            .padding([.top, .bottom], 20)
            
            Image("bungee")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 5.0, x: 3, y: 3)
                .padding(.bottom, 50)
            
            VStack(alignment: .leading, spacing: 10) {
                TextField("Username", text: self.$username)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0, x: 3, y: 3)
                SecureField("Password", text: self.$password)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0, x: 3, y: 3)
            }.padding([.leading, .trailing], 27.5)
            
            Button(action: {
            API.login(username: self.username, password: self.password){
                (response: LoginResult) in
                if (response.type == LoginResultType.SUCCESS) {
                    print("be orosbu")
                    self.loggedIn.toggle()
                }
            }}) {
            Text("Sign In")
                 .font(.headline)
                 .foregroundColor(.white)
                 .padding()
                 .frame(width: 300, height: 50)
                 .background(Color.green)
                 .cornerRadius(15.0)
                 .shadow(radius: 5.0, x: 3, y: 3)
            }.padding(.top, 50)
            
            Spacer()
            
            HStack {
               Text("Don't have an account? ")
               Button(action: {
                self.showingRegister.toggle()
               }) {
                   Text("Sign Up")
                       .foregroundColor(.white)
               }.sheet(isPresented: $showingRegister) {
                    RegisterView()
                }
            }
            Spacer()
        }.background(
        LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                       startPoint: .top,
                       endPoint: .bottom).edgesIgnoringSafeArea(.all)
        )
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

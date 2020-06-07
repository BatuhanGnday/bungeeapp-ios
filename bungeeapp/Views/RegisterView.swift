//
//  RegisterView.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 6.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import SwiftUI
import KeyboardObserving

struct RegisterView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var success: Bool = false
    @State private var showingAlert: Bool = false
    
    var body: some View {
        SwiftUIKeyboardHost {
            VStack() {
              Text("Bungee | Sign Up")
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
                    API.register(username: self.username, password: self.password) {
                        (response: RegisterResult) in
                        print(response)
                        if (response.getType() == RegisterResultType.SUCCESS) {
                            self.success.toggle()
                        }
                        if (response.getType() == RegisterResultType.USERNAME_EXISTS) {
                            self.password = ""
                            self.username = ""
                            self.showingAlert.toggle()
                        }
                }}){
                    Text("Sign Up")
                         .font(.headline)
                         .foregroundColor(.white)
                         .padding()
                         .frame(width: 300, height: 50)
                         .background(Color.green)
                         .cornerRadius(15.0)
                         .shadow(radius: 5.0, x: 3, y: 3)
                }.padding(.top, 40).alert(isPresented: self.$showingAlert) {
                    Alert(title: Text("Username already used"), message: Text("Please try again with another username"), dismissButton: .default(Text("Let's try")))
                }
                Spacer()
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                               startPoint: .top,
                               endPoint: .bottom).edgesIgnoringSafeArea(.all)
            )
        }.background(SwifUIDismissKeyboard())
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

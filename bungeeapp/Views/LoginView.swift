//
//  LoginView.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 6.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showingRegister: Bool = false
    @State private var loggedIn: Bool = false
    @State private var loginFail: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack() {
              Text("Bungee | Login")
                .font(.largeTitle)
                .foregroundColor(Color.black)
                .padding([.top], 20)
                
                Spacer()
                /*Image("bungee")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 5.0, x: 3, y: 3)
                    .padding(.bottom, 30)*/
                
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
                
                NavigationLink(destination: FeedView(), isActive: $loggedIn) {
                    Button(action: {
                        API.login(username: self.username, password: self.password){
                            (response: LoginResult) in
                            if (response.type == LoginResultType.SUCCESS) {
                                self.loggedIn.toggle()
                            } else {
                                self.loginFail = true
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
                }.hiddenNavigationBarStyle()
                
                Spacer()
                HStack {
                   Text("Don't have an account? ")
                   Button(action: {
                    self.showingRegister.toggle()
                   }) {
                       Text("Sign Up")
                           .foregroundColor(.white)
                   }.sheet(isPresented: self.$showingRegister) {
                        RegisterView()
                    }
                }.padding(.bottom, 30)
            }.background(
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                               startPoint: .top,
                               endPoint: .bottom).edgesIgnoringSafeArea(.all)
            ).padding(.bottom, keyboardHeight).onReceive(Publishers.keyboardHeight) {
                self.keyboardHeight = $0
            }
        }.onTapGesture {
            self.endEditing()
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}



struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}


// burdan sonrası dikkaattt

extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        // 3.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

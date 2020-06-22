//
//  LoginView.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 6.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import SwiftUI
import Combine
import KeyboardObserving

struct LoginView: View {
    @State private var showingRegister: Bool = false
    @State private var loggedIn: Bool = false
    @State private var loginFail: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @ObservedObject private var loginVM: LoginViewModel
    let client: API
    
    init() {
        self.client = API()
        self.loginVM = LoginViewModel(api: client)
    }
    
    var body: some View {
        KeyboardObservingView {
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
                        TextField("Username", text: Binding<String>(
                        get: {self.loginVM.username},
                        set: {self.loginVM.username = $0}))
                            .padding()
                            .background(Color.themeTextField)
                            .cornerRadius(20.0)
                            .shadow(radius: 5.0, x: 3, y: 3)
                        SecureField("Password", text: Binding<String>(
                        get: {self.loginVM.password},
                        set: {self.loginVM.password = $0}))
                            .padding()
                            .background(Color.themeTextField)
                            .cornerRadius(20.0)
                            .shadow(radius: 5.0, x: 3, y: 3)
                    }.padding([.leading, .trailing], 27.5)
                    
                    Button(action: {
                        print("username: \(self.loginVM.username) password: \(self.loginVM.password)")
                        self.loginVM.login() { b in
                            self.loggedIn = b
                        }
                    }) {
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
                        }.sheet(isPresented: self.$showingRegister) {
                            RegisterView()
                        }
                    }.padding(.bottom, 30)
                }.background(
                    LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                                   startPoint: .top,
                        endPoint: .bottom).edgesIgnoringSafeArea(.all)
                )
            }
        }.onTapGesture {
            self.endEditing()
        }.navigate(to: FeedView(), when: $loggedIn)
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

extension View {

    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<SomeView: View>(to view: SomeView, when binding: Binding<Bool>) -> some View {
        modifier(NavigateModifier(destination: view, binding: binding))
    }
}


// MARK: - NavigateModifier
fileprivate struct NavigateModifier<SomeView: View>: ViewModifier {

    // MARK: Private properties
    fileprivate let destination: SomeView
    @Binding fileprivate var binding: Bool


    // MARK: - View body
    fileprivate func body(content: Content) -> some View {
        NavigationView {
            ZStack {
                content
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                NavigationLink(destination: destination
                    .navigationBarTitle("")
                    .navigationBarHidden(true),
                               isActive: $binding) {
                    EmptyView()
                }
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

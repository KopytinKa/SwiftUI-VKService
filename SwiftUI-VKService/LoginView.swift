//
//  LoginView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 04.10.2021.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var shouldShowLogo: Bool = true
    
    private let keyboardIsOnPublisher = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .map { _ in true },
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }
    ).removeDuplicates()
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("login_wallpaper")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if shouldShowLogo {
                        Label("VK Client", systemImage: "bonjour")
                            .padding(.top, 32)
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        Text("Логин:")
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                        Spacer()
                        TextField("Введи логин...", text: $login)
                            .frame(maxWidth: 200)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .frame(maxWidth: 300)
                    
                    HStack {
                        Text("Пароль:")
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                        Spacer()
                        SecureField("Введи пароль...", text: $password)
                            .frame(maxWidth: 200)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .frame(maxWidth: 300)
                    
                    HStack {
                        Button(action: { print("Hello") }) {
                            Text("Войти")
                                .font(.title3)
                        }
                        .frame(width: 100, height: 40)
                        .background(Color.orange)
                        .cornerRadius(20)
                        .disabled(login.isEmpty || password.isEmpty)
                        
                        if shouldShowLogo {
                            Image("vmeste_logo")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: 350)
                .padding(.top, 50)
            }
            .onReceive(keyboardIsOnPublisher) { isKeyboardOn in
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    self.shouldShowLogo = !isKeyboardOn
                }
            }
        }
        .accentColor(.purple)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

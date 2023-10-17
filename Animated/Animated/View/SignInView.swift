//
//  SignInView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 17.07.2023.
//

import SwiftUI
import RiveRuntime

struct SignInView: View {
    
    @Binding var showModel: Bool
    let check = RiveViewModel(fileName: "check" , stateMachineName: "State Machine 1")
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    @Binding var didSignIn: Bool
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var registerVM: RegisterViewModel
    
    func logIn() {
        
        //MARK: BUG VAR COZ
        if loginViewModel.isAuth {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                check.triggerInput("Check")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                loginViewModel.isLoading = false
                confetti.triggerInput("Trigger explosion")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation(.spring()) {
                    showModel = false
                }
            }
        }
        
        
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                check.triggerInput("Error")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                loginViewModel.isLoading = false
            }
        }
    }
    
    func didRegister() {
        if registerVM.isRegister == true {
            withAnimation(.spring()) {
                showModel = false
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            
            content
            
            if loginViewModel.isSignUp {
                SignUpView(didSignIn: $didSignIn, showModal: $showModel)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(2)
                    .environmentObject(loginViewModel)
                    .environmentObject(RegisterViewModel())
                    .environmentObject(LocationService())
                    .onDisappear {
                        didRegister()
                    }
                    
                    
                    
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 24) {
            Text("Sign In")
                .customFont(.largeTitle)
            Text("Embark on an Enchanting Journey of Discovery! Crack the Open Feature and Unleash a World of Wonders. Welcome to a Realm Where Innovation and Imagination Unite, Awaiting Your Curiosity!")
                .customFont(.headline)
            
            VStack(alignment: .leading) {
                Text("Email")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $loginViewModel.username)
                    .customTextField(image: Image("Icon Email"))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            
            VStack(alignment: .leading ) {
                Text("Password")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                SecureField("", text: $loginViewModel.password)
                    .customTextField(image: Image("Icon Lock"))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    
            }
            
            Button {
                loginViewModel.isLoading = true
                loginViewModel.login()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    logIn()
                }
            } label: {
                Label("Sign In", systemImage: "arrow.right")
                    .customFont(.headline)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: 0xf77d8e))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 20, x: 0, y: 10)
            }
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.1)
                Text("OR")
                    .customFont(.subheadline2)
                    .foregroundColor(.black.opacity(0.3))
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.1)
            }
            
            
            HStack {
                
                Spacer()
                Image("Logo Apple")
                Spacer()
                Image("Logo Google")
                Spacer()
            }
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.1)
                Text("Don't have an account ?")
                    .customFont(.subheadline2)
                    .foregroundColor(.black.opacity(0.3))
                    .fixedSize(horizontal: true, vertical: false)
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.1)
            }
            
            Button {
                withAnimation(.spring()) {
                    loginViewModel.isSignUp = true
                }
            } label: {
                Label("Sign Up", systemImage: "arrow.up")
                    .customFont(.headline)
                    .padding(20)
                    .background(Color(hex: 0xf77d8e))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 20, x: 0, y: 10)
            }
        }
        .padding(30)
        .background(.regularMaterial)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(LinearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding()
        .overlay(
            ZStack {
                if loginViewModel.isLoading {
                    check.view()
                        .frame(width: 100, height: 100)
                        .allowsHitTesting(false)
                }
                confetti.view()
                    .scaleEffect(3)
                    .allowsHitTesting(false)
            }
        )
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(showModel: .constant(false), didSignIn: .constant(false))
            .environmentObject(LoginViewModel())
            .environmentObject(RegisterViewModel())
    }
}

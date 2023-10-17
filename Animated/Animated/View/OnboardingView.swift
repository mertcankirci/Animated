//
//  OnboardingView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 17.07.2023.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    
    let button = RiveViewModel(fileName: "button")
    @State var showModal = false
    @State var didSignIn = false
    @Binding var show: Bool
    @StateObject var loginViewModel = LoginViewModel()
    @EnvironmentObject var registerVM: RegisterViewModel
    
    
    var body: some View {
        //MARK: Burada bi sikinti var onu coz
                
            ZStack {

                
                background
                    
                
                content
                    .offset(y: showModal ? -50: 0)

                
                Color("Shadow")
                    .opacity(showModal ? 0.3 : 0.0)
                    .ignoresSafeArea()
                
                if didSignIn {
                    ProfileView()
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding()
                        .overlay(
                            
                            Button {
                                withAnimation(.spring()) {
                                    show = false
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.black)
                                    .background(.white)
                                    .mask(Circle())
                                    .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                            }
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        )
                        .zIndex(1)
                        .environmentObject(LoginViewModel())
                        .environmentObject(registerVM)
                }
                
                else {
                    SignInView(showModel: $showModal, didSignIn: $didSignIn)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding()
                        .overlay(
                            
                            Button {
                                withAnimation(.spring()) {
                                    showModal = false
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.black)
                                    .background(.white)
                                    .mask(Circle())
                                    .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                            }
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        )
                        .zIndex(1)
                        .onDisappear(perform: {
                        
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.1) {
                                print("Register bu \(registerVM.isRegister)")
                            }
                        })
                        .environmentObject(LoginViewModel())
                        .environmentObject(registerVM)
                        .environmentObject(LocationService())
                }
                
                
                Button {
                    withAnimation {
                        show = false
                    }
                    
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 36, height: 36)
                        .background(.white)
                        .foregroundColor(.black)
                        .mask(Circle())
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(20)
                .padding(.trailing, 20)
                .offset(y: showModal ? -200 : 80)
                
                
            }
        
    }
    
    var background: some View {
      
            RiveViewModel(fileName: "space_coffee").view()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            
    }
    
    var content : some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Crack Open the Future.")
                .font(.custom("Poppins Bold", size: 55, relativeTo: .largeTitle))
                .frame(width: 260, alignment: .leading)
                .foregroundColor(.white)
                
            
            Text("Embark on an Enchanting Journey of Discovery! Crack the Open Feature and Unleash a World of Wonders. Unravel the Secrets Within and Experience a New Dimension of Possibilities. Welcome to a Realm Where Innovation and Imagination Unite, Awaiting Your Curiosity to Be Explored!")
                .customFont(.body)
                .foregroundColor(.white)
                .opacity(0.7)
                .frame(width: 366)
                
            Spacer()
            
            button.view()
                .frame(width: 236, height: 64)
                .overlay(
                    Label("Get Started", systemImage: "arrow.forward")
                        .offset(x:4 , y:4)
                        .font(.headline)
                )
                .background(
                    Color.black
                        .cornerRadius(30)
                        .blur(radius: 10)
                        .opacity(0.3)
                        .offset(y: 10)
                )
                .onTapGesture {
                    button.play(animationName: "active")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.spring()) {
                            showModal = true
                        }
                    }
            }
            
            Text("Purchase includes all fortune types add free !")
                .customFont(.footnote)
                .foregroundColor(.white)
                .opacity(0.7)
                .frame(width: 366)
            
            
        }
        .padding(40)
        .padding(.top, 40)
    }
    
}



struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(show: .constant(true))
            .environmentObject(LoginViewModel())
            .environmentObject(RegisterViewModel())
            
    }
}

//
//  ContentView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 17.07.2023.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    
    @State var type : FortuneType
    @State var isOpen = false
    @State var show = false
    var button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false)
    @EnvironmentObject var viewModel : ChooseModeViewModel
    
    
    
    
    
    var body: some View {
        ZStack {
                Color("Background 2")
                    .ignoresSafeArea()
            

            
            SideMenu()
                .opacity(isOpen ? 1 : 0)
                .offset(x: isOpen ? 0 : -300)
                .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0))
            
            HomeView(type: $type, show: $show)
                .offset(y: viewModel.isZodiacView ? 30 : 0)
                .safeAreaInset(edge: .bottom) {
                    
                        Color.clear
                            .frame(height: 80)
                    
                }
                .safeAreaInset(edge: .top) {
                    
                        Color.clear
                            .frame(height: 104)
                    
                }
            .mask(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
            )
            .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0))
            .offset(x: isOpen ? 265 : 0)
            .scaleEffect(isOpen ? 0.9 : 1)
            .scaleEffect(show ? 0.92 : 1)
            .ignoresSafeArea()
            
            
            if !show && (type != .horoscope || type != .cookie) {
                Image(systemName: "person")
                    .frame(width: 36, height: 36)
                    .background(.white)
                    .mask(Circle())
                    .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
                    .onTapGesture{
                        withAnimation(.spring()) {
                            show.toggle()
                            type = .tarot
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding()
                    .offset(y: 4)
                    .offset(x: isOpen ? 100 : 0)
                
                
                button.view()
                    .frame(width: 44, height: 44)
                    .mask(Circle())
                    .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding()
                    .offset(x: isOpen ? 216 : 0)
                    .onTapGesture {
                        
                        button.setInput("isOpen", value: isOpen)
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            isOpen.toggle()
                        }
                    }
                    .onChange(of: isOpen) { newValue in
                        if newValue == true {
                            UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
                        }
                        else {
                            UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
                        }
                    }
            }
            if show && type == .tarot{
                OnboardingView(show: $show)
                    .background(Color(hex: 0x25142f))
                    .mask(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                    )
                    .shadow(color: .black.opacity(0.5), radius: 40, x: 0, y: 40)
                    .ignoresSafeArea(.all, edges: .top)
                    .transition(.move(edge: .top))
                    .offset(y: show ? -10 : 0)
                    .zIndex(1)
                    .environmentObject(LoginViewModel())
                    .environmentObject(RegisterViewModel())
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(type: .tarot)
            .environmentObject(ChooseModeViewModel())
    }
}

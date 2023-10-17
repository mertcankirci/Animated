//
//  ZodiacSignView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 22.07.2023.
//

import SwiftUI
import RiveRuntime

struct ZodiacSignView: View {
    
    let button = RiveViewModel(fileName: "button")

    @Binding var show: Bool
    @EnvironmentObject var viewModel: ChooseModeViewModel
    @EnvironmentObject var zodiacVM: ZodiacSignViewModel

    
    var body: some View {
        ZStack {
            
            background
            
            content
                .offset(y: zodiacVM.showModal ? -50: 0)
            if viewModel.isZodiacView {
                Color(hex: 0x040910)
            }
            else {
                Color("Shadow")
                    .opacity(zodiacVM.showModal ? 0.3 : 0.0)
                    .ignoresSafeArea()
            }
            
            if zodiacVM.showModal {
                ChooseModeView(show: show)
                    .environmentObject(ChooseModeViewModel())
                    .frame(width: 450, height: 900)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .overlay(

                            Button {
                                withAnimation(.spring()) {
                                    zodiacVM.showModal = false
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(.black)
                                    .background(.white)
                                    .mask(Circle())
                                    .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                            }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .offset(y: viewModel.isZodiacView ? 900 : 15)

                    )
                    .offset(y: 35)
                    .zIndex(1)
                    .environmentObject(LocationService())
                    .environmentObject(ZodiacSignViewModel())
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
                .offset(y: zodiacVM.showModal ? 300 : 80)
            
        }
    }
    
    var content : some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Choose Mode")
                .font(.custom("Poppins Bold", size: 55, relativeTo: .largeTitle))
                .frame(width: 260, alignment: .leading)
                .foregroundColor(.white)
                
            
            Text("You can choose which specific aspect of your life your AI-generated fortune teller should read your fortune for. After 2 clicks, you can start talking with your fortune-teller about your future. ")
                .customFont(.body)
                .foregroundColor(.white)
                .frame(width: 366)

            Spacer()

            button.view()
                .frame(width: 236, height: 64)
                .overlay(
                    Label("Choose mode", systemImage: "arrow.forward")
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
                            zodiacVM.showModal = true
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
    
    var background: some View {

            RiveViewModel(fileName: "planet").view()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
    }
}

struct ZodiacSignView_Previews: PreviewProvider {
    static var previews: some View {
        ZodiacSignView(show: .constant(true))
            .environmentObject(ChooseModeViewModel())
            .environmentObject(ZodiacSignViewModel())
    }
}

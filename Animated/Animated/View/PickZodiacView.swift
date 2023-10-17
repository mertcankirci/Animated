//
//  PickZodiacView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 22.07.2023.
//


import SwiftUI

struct PickZodiacView: View {
    
    @State var mod: Mode
    @EnvironmentObject var viewModel: ChooseModeViewModel
    @State var isChatView: Bool = false
    @State var didFavourite: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Image("Astrology")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()
                            
            Color("Background 2")
                .opacity(0.6)
                .ignoresSafeArea()
            
            
            ScrollView {
                content
                    .offset(y: -1)
            }
            .padding(.top, 60)
            .frame(maxHeight: .infinity)
            .ignoresSafeArea(edges: .vertical)
            
            

        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .foregroundColor(.white)
        .fullScreenCover(isPresented: $isChatView) {
            ChatView()
        }
        
        
        
    }
    
    
    var content: some View {
        VStack {
            HStack(spacing: 24) {
                
                Button {
                    viewModel.isZodiacView = false
                } label: {
                    Image(systemName: "lessthan")
                        .customFont(.title3)
                        .frame(width: 26, height: 26)
                        .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 9, x: 0, y: 4)
                }
                
                Text("Your Fortune Telling")
                    .customFont(.title)
                    .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 8, x: 0, y: 10)
                
                    Image(systemName: didFavourite ? "star.fill" : "star")
                        .customFont(.title3)
                     
                        .onTapGesture {
                            withAnimation(.spring()) {
                                didFavourite.toggle()
                            }
                        }
            }
                
                Text("Get ready to experience the mysterius side of fortune telling with your AI Generated Fortune Teller !")
                    .customFont(.body)
                    .padding()
            
            .frame(width: UIScreen.main.bounds.width)
            .padding(.horizontal, 100)
            
            VStack {
                HStack {
                    Rectangle()
                        .frame(height: 1)
                    Text("Percentage of Compliance")
                        .customFont(.title2)
                        .fixedSize(horizontal: true, vertical: false)
                        .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 8, x: 0, y: 10)
                        
                    Rectangle()
                        .frame(height: 1)
                }
                .frame(maxWidth: .infinity, alignment: .center)
               
                HStack(alignment: .top, spacing: 30) {
                    VStack {
                        Text("\("Mert"):")
                            .customFont(.title3)
                            .frame(width: 100, alignment: .leading)
                            .fixedSize(horizontal: true, vertical: false)
                        
                        if mod == .love {
                            Text("\("Memre"):")
                                .customFont(.title3)
                                .frame(width: 100, alignment: .leading)
                                .fixedSize(horizontal: true, vertical: true)
                        }
                        
                    }
                    
                    VStack{
                        Text("Aquarius")
                            .customFont(.title3)
                            .frame(width: 200, alignment: .leading)
                            .fixedSize(horizontal: true, vertical: false)
                        if mod == .love {
                            Text("Another Sign")
                                .customFont(.title3)
                                .frame(width: 200, alignment: .leading)
                                .fixedSize(horizontal: true, vertical: true)
                        }
                    }
                    if mod == .love {
                        VStack(spacing: 0) {
                            HeartShapeView(endPrecent: 66.0)
                                .frame(width: 34, height: 34)
                        }
                        .offset(x: -60, y: 5)
                        .padding(.trailing, 32)
                    }
                }
                .padding(.leading, 60)
                VStack {
                    Text("Positives")
                        .fixedSize(horizontal: true, vertical: false)
                        .customFont(.title2)
                        .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 8, x: 0, y: 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 100)
                        .padding()
                    
                    Text("Avantajlarini anlatan textasdnjkasndjkasdkjasdjkasjkdnsajkdnakjsndjkandsjkansdkjansjdnfjsdnfjksdnfjksdfnjkdsnfjksdfnjksnfdjksdnfjkjskdfnjsdnfjksdnfkjsdnfjksdnfjksdnfjksdnf")
                        .fixedSize(horizontal: false, vertical: true)
                        .customFont(.body)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(
                                    Color("Background").opacity(0.1)
                                )
                        )
                        .frame(width: 350)
                    
                    Text("Negatives")
                        .fixedSize(horizontal: true, vertical: false)
                        .customFont(.title2)
                        .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 8, x: 0, y: 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 100)
                        .padding()
                    
                    Text("Dezavantajlari anlatan textasdnjkasndjkasdkjasdjkasjkdnsajkdnakjsndjkandsjkansdkjansjdnfjsdnfjksdnfjksdfnjkdsnfjksdfnjksnfdjksdnfjkjskdfnjsdnfjksdnfkjsdnfjksdnfjksdnfjksdnf")
                        .fixedSize(horizontal: false, vertical: true)
                        .customFont(.body)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(
                                    Color("Background").opacity(0.1)
                                )
                            )
                        .frame(width: 350)
                    
                    Text("Detailed Explonation")
                        .fixedSize(horizontal: true, vertical: false)
                        .customFont(.title2)
                        .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 8, x: 0, y: 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 100)
                        .padding()
                    
                    Text("DETAY SDNFJSDFKJS DNFJKSNDFJKS NDFKJNSDJFKNSD KJFNSJKDFNJKSDN FJKSDNF JKSDNFJKS DNFKJSNDFJK NSDFJKNSDJKFN JKSDNFJKSNDFJKS NDFJKNSDJKFNJS KDNFJKSNDF NSDKFJSNDFJNSFD KJSNDKFJNSDJK FSJKDNFJDK SNFJK SDNFKJSNDF JKSNDFNSDFJKSND FJKSNJDF KSDNFJ SKDNFJKN")
                        .fixedSize(horizontal: false, vertical: true)
                        .customFont(.body)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(
                                    Color("Background").opacity(0.1)
                                )
                            )
                        .frame(width: 350)
                        
                    
                    Text("You can chat with your fortune teller about your fortune now !")
                        .foregroundColor( Color("Background").opacity(0.8)  )
                        .fixedSize(horizontal: false, vertical: true)
                        .customFont(.title3)
                        .frame(width: 400)
                    
                        

                    HStack(spacing: 24) {
                        
                        VStack {
                            Image(systemName: "message.badge.filled.fill")
                                .customFont(.title2)
                                .frame(width: 36, height: 36)

                            Text("Ask fortune teller")
                                .customFont(.headline)
                        }
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isChatView = true
                            }
                        }
                    }
                    .frame(width:150 ,height: 55, alignment: .top)
                    .padding(.vertical, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(
                                Color("Background").opacity(0.3)
                            )
                    )
                }
                .padding(.bottom, 50)
                
            }
            
        }
        .padding(.trailing, 10)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(LinearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
    }
    
}

struct PickZodiacView_Previews: PreviewProvider {
    static var previews: some View {
        PickZodiacView(mod: .love)
    }
}

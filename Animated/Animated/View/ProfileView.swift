//
//  ProfileView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 4.08.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    let arr = [1, 2 ,3 ,4, 5, 6, 7, 8 ,9 , 10]
    
    var body: some View {
        content
            .onAppear {
                //MARK: Memre ile konus getProfile detaylarini anlat
                //viewModel.getProfile()
            }
    }
    
    var content: some View {
        VStack {

                Text("Profile")
                    .customFont(.largeTitle)
                    .foregroundColor(Color("Background 2"))
                    .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 8, x: 0, y: 15)
            
            VStack {

                ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                        ForEach(arr, id: \.self) { _ in
                            VStack {
                                Text("Moon")
                                    .customFont(.title2)
                                
                                Image("moon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 72, height: 72)
                                
                                Text("Your Sign")
                                    .customFont(.headline)
                                
                                Text("Aquarius")
                                    .customFont(.title3)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            .padding()
                        }
                    }
                }
                .frame(height: 200)
                VStack {
                    Text("Your Information")
                        .customFont(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 8, x: 0, y: 15)
                        .padding(.vertical)
                        
                    Text("Name")
                        .customFont(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Mert")
                        .customFont(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Birth Date")
                        .customFont(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Mert")
                        .customFont(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Birth Location")
                        .customFont(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Meert")
                        .customFont(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Occupation")
                        .customFont(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Mert")
                        .customFont(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Relationship Status")
                        .customFont(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding()
                
                
                Spacer()
                    
            }
            .frame(maxWidth: .infinity)
            .background(Color("Background 2"))
            .foregroundColor(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
        .background(.regularMaterial)
        .foregroundColor(Color("Background 2"))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(LinearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding()
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

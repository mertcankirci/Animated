//
//  CustomTextField.swift
//  Animated
//
//  Created by Mertcan Kırcı on 17.07.2023.
//

import SwiftUI

struct CustomTextField: ViewModifier {
    
    var image: Image 
        
    
    
    func body(content: Content) -> some View {
        content
            .padding(15)
            .padding(.leading, 36)
            .background(.white)
            .mask(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke()
                    .fill(.black.opacity(0.1))
            )
            .overlay(
                image
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
            )
    }
}

struct SignUpTextField: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.leading, 100)
            .padding(20)
            .background(.white)
            .mask(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke()
                    .fill(Color(hex: 0xf77d8e))
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: 0xf77d8e))
                    .foregroundColor(.black)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
            )
    }
    
}

extension View {
    func customTextField(image: Image) -> some View {
        modifier(CustomTextField(image: image))
    }
    
    func signUpTextField() -> some View {
        modifier(SignUpTextField())
    }
}



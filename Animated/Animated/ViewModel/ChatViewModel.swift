//
//  PickerViewModel.swift
//  Animated
//
//  Created by Mertcan Kırcı on 29.07.2023.
//

import SwiftUI
import Combine

class ChatViewModel: ObservableObject {
    
}

struct KeyboardAwareModifier: ViewModifier {
        @State private var keyboardHeight: CGFloat = 0

        private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
            Publishers.Merge(
                NotificationCenter.default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
                    .map { $0.cgRectValue.height },
                NotificationCenter.default
                    .publisher(for: UIResponder.keyboardWillHideNotification)
                    .map { _ in CGFloat(0) }
           ).eraseToAnyPublisher()
        }

        func body(content: Content) -> some View {
            withAnimation(.spring()) {
                content
                    .padding(.bottom, keyboardHeight)
                    .onReceive(keyboardHeightPublisher) { self.keyboardHeight = $0 }
            }
        }
    }




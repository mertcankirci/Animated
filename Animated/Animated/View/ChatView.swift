//
//  ChatView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 28.07.2023.
//

import SwiftUI
import RiveRuntime

struct ChatView: View {
    
    @State var message: String = ""
    @State var messages: [String] = []
    @Environment(\.dismiss) var dismiss
    @State var isTf: Bool = false
    @FocusState private var nameIsFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black
            RiveViewModel(fileName: "stars").view()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

            
            VStack {
                      topBar
                
                ScrollView {
                    ForEach(messages, id: \.self ) { messageText in
                        if messageText.contains("[USER]") {
                            let newMessage = messageText.replacingOccurrences(of: "[USER]", with: "")
                            
                            HStack {
                                Spacer()
                                Text(newMessage)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color(hex: 0xf77d8e))
                                    .cornerRadius(20, corners: [.bottomLeft, .topLeft, .topRight])
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                            }
                        }
                        else {
                            HStack {
                                Text(messageText)
                                    .padding()
                                    .foregroundColor(.black)
                                    .background(Color("Background"))
                                    .cornerRadius(20, corners: [.bottomRight, .topLeft, .topRight])
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }
                    }.rotationEffect(.degrees(180))
                }
                .rotationEffect(.degrees(180))
                bottomChat
            }
            .KeyboardAwarePadding()
            .animation(.spring(), value: isTf)
            .padding(.top, 60)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.spring()) {
                        messages.append(getBotResponse(message: "Open"))
                    }
                }
            }
        }
        .ignoresSafeArea()
        .foregroundColor(.white)
    }
    
    var bottomChat: some View {
        HStack {
            TextField("Type something", text: $message)
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(10)
                .focused($nameIsFocused)
                .onSubmit {
                    sendMessage(message: message)
                    isTf = false
                }
                .onTapGesture {
                    isTf = true
                }
                
            
            Button {
                sendMessage(message: message)
                isTf = false
                nameIsFocused = false
            } label: {
                Image(systemName: "paperplane.fill")
                    .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 8, x: 0, y: 10)
            }
            .font(.system(size: 26))
            
            if isTf {
                Button {
                    isTf = false
                    nameIsFocused = false
                    message = ""
                    
                } label: {
                    Image(systemName: "xmark")
                }
                .font(.system(size: 26))

            }
        }
        .padding(30)
    }
    
    var topBar: some View {
        HStack {
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "lessthan")
                    .customFont(.title2)
                    .frame(width: 26, height: 26)
                    .foregroundColor(Color("Background"))
                    .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 9, x: 0, y: 4)
            }
            .offset(x: -50)
            
            Text("Fortune Teller")
                .customFont(.largeTitle)
                .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 8, x: 0, y: 10)
                .offset(x: -10)
               
        }
    }
    
    func sendMessage(message: String) {
        withAnimation {
            messages.append("[USER]" + message)
            self.message = ""
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                messages.append(getBotResponse(message: message))
            }
        }
    }
    
    func getBotResponse(message: String) -> String {
        let tempMessage = message.lowercased()
        
        
        if tempMessage == "open" {
            return "Welcome to your personalized AI Fortune Teller ! Ask me anything about your fortune and let me give you hints about your mysterius future !"
        }
        else if tempMessage.contains("hello") {
            return "Hey there !"
        }
        else if tempMessage.contains("goodbye") {
            return "Talk to you later"
        }
        else {
            return "Sa"
        }
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

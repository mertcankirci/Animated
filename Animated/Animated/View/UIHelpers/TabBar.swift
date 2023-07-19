//
//  TabBar.swift
//  Animated
//
//  Created by Mertcan Kırcı on 18.07.2023.
//

import SwiftUI
import RiveRuntime

struct TabBar: View {
    
    @AppStorage("selectedTab") var tabSelection: Tab = .chat
    
    
    var tabItems = [
        TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), tab: .chat),
        TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "SEARCH_Interactivity", artboardName: "SEARCH"), tab: .search),
        TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "TIMER_Interactivity", artboardName: "TIMER"), tab: .timer),
        TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "BELL_Interactivity", artboardName: "BELL"), tab: .bell),
        TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "USER_Interactivity", artboardName: "USER"), tab: .user)
    ]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                content
            }
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(Color("Background 2").opacity(0.8))
            .background(.ultraThinMaterial)
            .mask(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .shadow(color: Color("Background 2").opacity(0.3), radius: 20, x: 0, y: 20)
            .overlay(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .stroke(.linearGradient(colors: [.white.opacity(0.5), .white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
            .padding(.horizontal, 24)
        }
    }
    
    var content: some View {
        ForEach(tabItems) { item in
            Button {
                tabSelection = item.tab
                item.icon.setInput("active", value: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    item.icon.setInput("active", value: false)
                }
                print(tabSelection)
            } label: {
                item.icon.view()
                    .frame(width: 36, height: 36)
                    .frame(maxWidth: .infinity)
                    .opacity(tabSelection == item.tab ? 1 : 0.5)
                    .background(
                        VStack {
                            RoundedRectangle(cornerRadius: 2)
                                .frame(width: tabSelection == item.tab ? 20 : 0, height: 4)
                                .offset(y: -4)
                                .opacity(tabSelection == item.tab ? 1 : 0)
                            Spacer()
                        }
                    )
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    
    static let tabSelection = TabSelectionManager()
    static var previews: some View {
        TabBar()
        
    }
}

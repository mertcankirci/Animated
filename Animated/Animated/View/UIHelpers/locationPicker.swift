//
//  locationPicker.swift
//  Animated
//
//  Created by Mertcan Kırcı on 25.07.2023.
//

import SwiftUI

struct LocationPicker: View {
    
    @StateObject var locationService: LocationService
    @Binding var isDismissed: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
                Form {
                    Section(header: Text("Location Search")) {
                        ZStack(alignment: .trailing) {
                            TextField("Search", text: $locationService.queryFragment)
                            // This is optional and simply displays an icon during an active search
                            if locationService.status == .isSearching {
                                Image(systemName: "clock")
                                    .foregroundColor(Color.gray)
                            }
                            else {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color.gray)
                                    .onTapGesture {
                                        locationService.queryFragment = ""
                                    }
                            }
                        }
                    }
                    
                    Section(header: Text("Results")) {
                        List {
                            // With Xcode 12, this will not be necessary as it supports switch statements.
                           
                                switch locationService.status {
                                case .noResults: AnyView(Text("No Results"))
                                case .error(let description): AnyView(Text("Error: \(description)"))
                                default: AnyView(EmptyView())
                                }
                         

                            ForEach(locationService.searchResults, id: \.self) { completionResult in
                                // This simply lists the results, use a button in case you'd like to perform an action
                                // or use a NavigationLink to move to the next view upon selection.
                                Text(completionResult.title)
                                    .onTapGesture {
                                        locationService.queryFragment = completionResult.title
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            isDismissed = true
                                            dismiss()
                                        }
                                    }
                            }
                        }
                    }
                }
            }
    }
}

struct locationPicker_Previews: PreviewProvider {
    static var previews: some View {
        LocationPicker(locationService: LocationService(), isDismissed: .constant(false))
    }
}

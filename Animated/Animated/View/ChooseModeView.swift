//
//  ChooseModeView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 23.07.2023.
//

import SwiftUI
import RiveRuntime

struct ChooseModeView: View {
    
    @EnvironmentObject var locationService: LocationService
    @EnvironmentObject var viewModel: ChooseModeViewModel
    @EnvironmentObject var zodiacVM: ZodiacSignViewModel
    @State var show : Bool
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack {
            
            
            content
                .ignoresSafeArea(.all)
                .padding(.top, 40)
                .offset(y: viewModel.isZodiacView ? -50: 0)

        }
        .fullScreenCover(isPresented: $viewModel.isZodiacView) {
            PickZodiacView(mod: viewModel.selectedMode)
        }
    }
    
    var content: some View {
        
        ScrollView {
            VStack(spacing: 24) {
                
                Text("Choose Mode")
                    .customFont(.largeTitle)
                
                Picker("", selection: $viewModel.timeInterval) {
                    ForEach(Interval.allCases) { interval in
                        Text(interval.rawValue).tag(interval)
                            .background(Color.red)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                LazyHGrid(rows: columns, spacing: 8) {
                    ForEach(modeList.prefix(2)) { item in
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.1)
                        
                        ChooseItemView(item: item, selectedMode: $viewModel.selectedMode)
                    }
                }
                .padding(8)
                GridRow {
                    
                    ChooseItemView(item: modeList.dropFirst(2).first!, selectedMode: $viewModel.selectedMode)
                    
                }
                .padding(.vertical, 24)
                
                //MARK: BURAYA SEGMENTED PICKER GELECEK

                
                if viewModel.selectedMode == .love {
                        loveContent
            }
                else {
                   
                        Spacer()
                        Spacer()
                        button
                    
                }
                
                
                
            }
            .padding(30)
            .background(.regularMaterial)
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
    var loveContent: some View {
        
        VStack {
            Text("Your Crush's")
                .customFont(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            DatePicker(
                "",
                selection: $viewModel.date,
                displayedComponents: [.date, .hourAndMinute])
            .padding()
            .datePickerStyle(.compact)
            .applyTextColor(Color("Background"))
            .accentColor(.white)
            .padding()
            .background(
                Text("Birth Date")
                    .customFont(.subheadline)
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("Background 2"))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
            )
            VStack(spacing: 48) {
                TextField("", text: $viewModel.occupation)
                    .padding(.leading, 120)
                    .foregroundColor(.white)
                    .background(
                        Text("")
                            .customFont(.subheadline)
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color("Background 2"))
                            .foregroundColor(.white)
                            .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                            .cornerRadius(8, corners: [.topLeft])
                    )
                    .overlay(
                        Text("Occupation")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                TextField("", text: $viewModel.name)
                    .padding(.leading, 120)
                    .foregroundColor(.white)
                    .background(
                        Text("")
                            .customFont(.subheadline)
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color("Background 2"))
                            .foregroundColor(.white)
                            .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                            .cornerRadius(8, corners: [.topLeft])
                    )
                    .overlay(
                        Text("Name")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                
                HStack {
                    genderPicker
                        .frame(width: 130, height: 0)
                        .accentColor(.white)
                        .background(
                            Text("")
                                .customFont(.subheadline)
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color("Background 2"))
                                .foregroundColor(.white)
                                .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                                .cornerRadius(8, corners: [.topLeft])
                        )
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Label(viewModel.location , systemImage: "arrow.up")
                        .frame(width: 200, height: 0)
                        .customFont(.body)
                        .foregroundColor(.white)
                        .background(
                            Text("")
                                .customFont(.subheadline)
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color("Background 2"))
                                .foregroundColor(.white)
                                .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                                .cornerRadius(8, corners: [.topLeft])
                        )
                        .onTapGesture {
                            viewModel.showingSheet.toggle()
                        }
                        .sheet(isPresented: $viewModel.showingSheet) {
                            LocationPicker(locationService: locationService, isDismissed: $viewModel.didDismissed)
                                .onDisappear {
                                    withAnimation(.spring()) {
                                        viewModel.location = locationService.queryFragment
                                    }
                                }
                                
                        }
                }
                
               button

            }
        }
        
    }
    var genderPicker: some View {
        Picker("Gender", selection: $viewModel.selectedGender) {
            ForEach(Gender.allCases) { gender in
                Text(gender.rawValue).tag(gender)
            }
        }
        .pickerStyle(.automatic)
        .padding()
    }
    
    var button: some View {
        Button {
            
            withAnimation(.spring()) {
                viewModel.isZodiacView = true
            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//                withAnimation(.spring()) {
//                    show = false
//                }
            //}
            print(viewModel.isZodiacView)
            
            viewModel.getFortune()
            print(viewModel.date)
        } label: {
                Label("Start Fortune Telling", systemImage: "arrow.right")
                    .customFont(.title3)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color("Background 2"))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 20, x: 0, y: 10)
            
        }
    }
    
}

struct ChooseModeView_Previews: PreviewProvider {
    
    static var previews: some View {
        ChooseModeView(show: true)
            .environmentObject(LocationService())
            .environmentObject(ChooseModeViewModel())
    }
}

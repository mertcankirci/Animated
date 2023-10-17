//
//  SignUpView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 30.07.2023.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var locationService: LocationService
    @State var didDismissed: Bool = false
    @State var showingSheet: Bool = false
    @Binding var didSignIn: Bool
    @EnvironmentObject var loginViewModel : LoginViewModel
    @EnvironmentObject var registerVM : RegisterViewModel
    @Binding var showModal: Bool
    @Environment(\.dismiss) var dismiss
    
    
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                Text("Sign Up")
                    .customFont(.largeTitle)
                
                VStack(spacing: 24) {
                    
                    DatePicker(
                        "",
                        selection: $registerVM.date,
                        displayedComponents: [.date, .hourAndMinute])
                    .padding()
                    .datePickerStyle(.compact)
                    .applyTextColor(.black)
                    .accentColor(Color(hex: 0xf77d8e))
                    .background(
                        ZStack {
                            Color.white
                            
                            Text("Birth D.")
                                .customFont(.subheadline)
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    )
                    .mask(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke()
                            .fill(Color(hex: 0xf77d8e))
                            
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(hex: 0xf77d8e))
                            .foregroundColor(.black)
                            .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                            .cornerRadius(8, corners: [.topLeft])
                    )
                    VStack(spacing: 24) {
                        TextField("", text: $registerVM.occupation)
                            .signUpTextField()
                            .overlay(
                                Text("Occupation")
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 16)
                            )
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        TextField("", text: $registerVM.name)
                            .signUpTextField()
                            .overlay(
                                Text("Name")
                                    .foregroundColor(.black)
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
                                        .background(Color(hex: 0xf77d8e))
                                        .foregroundColor(.white)
                                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                                        .cornerRadius(8, corners: [.topLeft])
                                )
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Label(didDismissed ? locationService.queryFragment : "Location" , systemImage: "arrow.up")
                                .frame(width: 200, height: 0)
                                .customFont(.body)
                                .foregroundColor(.white)
                                .background(
                                    Text("")
                                        .customFont(.subheadline)
                                        .padding(20)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(hex: 0xf77d8e))
                                        .foregroundColor(.white)
                                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                                        .cornerRadius(8, corners: [.topLeft])
                                )
                                .onTapGesture {
                                   showingSheet.toggle()
                                }
                                .sheet(isPresented: $showingSheet) {
                                    LocationPicker(locationService: locationService, isDismissed: $didDismissed)
                                        .onDisappear(perform: {
                                            registerVM.location = locationService.queryFragment
                                        })
                                }
                        }
                        .padding(.top, 24)
                    }
                }
                .padding(.bottom ,24)
                .frame(maxWidth: .infinity)
                //MARK: HOROScope bitis
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $registerVM.username)
                        .customTextField(image: Image("Icon Email"))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        
                }
                
                VStack(alignment: .leading ) {
                    Text("Password")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    SecureField("", text: $registerVM.password)
                        .customTextField(image: Image("Icon Lock"))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                }
                
                Button {
                    registerVM.register()

                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        if registerVM.isRegister {
                            withAnimation(.spring()) {
                                print("Register bu \(registerVM.isRegister)")
                                showModal = false
                                didSignIn = true
                            }
                        }
                    }
                        
                } label: {
                    Label("Sign Up", systemImage: "arrow.up")
                        .customFont(.headline)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: 0xf77d8e))
                        .foregroundColor(.white)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .cornerRadius(8, corners: [.topLeft])
                        .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 20, x: 0, y: 10)
                }
                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.1)
                    Text("OR")
                        .customFont(.subheadline2)
                        .foregroundColor(.black.opacity(0.3))
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.1)
                }
                .padding(.vertical, 24)
                
                
                HStack {
                    Spacer()
                    Image("Logo Apple")
                    Spacer()
                    Image("Logo Google")
                    Spacer()
                }
                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.1)
                    Text("Already have an account ?")
                        .customFont(.subheadline2)
                        .foregroundColor(.black.opacity(0.3))
                        .fixedSize(horizontal: true, vertical: false)
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.1)
                }
                .padding(.vertical, 24)
                
                Button {
                    withAnimation(.spring()) {
                        loginViewModel.isSignUp = false
                    }
                } label: {
                    Label("Sign In", systemImage: "arrow.right")
                        .customFont(.headline)
                        .padding(20)
                        .background(Color(hex: 0xf77d8e))
                        .foregroundColor(.white)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .cornerRadius(8, corners: [.topLeft])
                        .shadow(color: Color(hex: 0xf77d8e).opacity(0.5), radius: 20, x: 0, y: 10)
                }
            }
        }
            .padding()
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
    
//    var horoscopeContent: some View {
//
//
//
//
//    }
    
    var genderPicker: some View {
        Picker("Gender", selection: $registerVM.gender) {
            ForEach(Gender.allCases) { gender in
                Text(gender.rawValue).tag(gender)
            }
        }
        .pickerStyle(.automatic)
        .padding()
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(didSignIn: .constant(false), showModal: .constant(true))
            .environmentObject(LocationService())
            .environmentObject(LoginViewModel())
            .environmentObject(RegisterViewModel())
            
    }
}

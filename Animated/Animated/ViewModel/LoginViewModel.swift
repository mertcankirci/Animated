//
//  LoginViewModel.swift
//  Animated
//
//  Created by Mertcan Kırcı on 1.08.2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var isAuth: Bool = false
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
    @Published var isSignUp = false
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        WebService().login(username: username, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "jwt")
                DispatchQueue.main.async {
                    self.isAuth = true
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

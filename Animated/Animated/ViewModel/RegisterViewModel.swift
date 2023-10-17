//
//  RegisterViewModel.swift
//  Animated
//
//  Created by Mertcan Kırcı on 1.08.2023.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    @Published var isRegister: Bool = false
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var gender: Gender = .male
    @Published var date: Date = Date()
    @Published var occupation: String = ""
    @Published var name: String = ""
    @Published var location: String = "Location"
    
    func register() {
        
        print("parameters", self.username, self.password, self.gender, self.date , self.location, self.name , self.occupation)
        
        let defaults = UserDefaults.standard
        
        WebService().register(username: username, password: password, gender: gender, birthDate: date, location: location, name: name, occupation: occupation, relationshipStatus: "Evli") { result in
            
            
            
            switch result {
                
            case .success(let token):
                defaults.setValue(token, forKey: "jwt")
                print(token)
                DispatchQueue.main.async {
                    self.isRegister = true
                }
                print(self.isRegister)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
}

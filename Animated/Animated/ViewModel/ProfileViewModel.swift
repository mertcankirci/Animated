//
//  ProfileViewModel.swift
//  Animated
//
//  Created by Mertcan Kırcı on 4.08.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var userProfile: GetProfileResponse = GetProfileResponse(name: "Mert", sign: "Aquarius", starMap: "https://i.pinimg.com/originals/aa/d4/6f/aad46fd62a293968f6c5e15aea5d52d4.jpg")
    
    func getProfile() {
        let defaults = UserDefaults.standard
        
        guard let token = defaults.string(forKey: "jwt") else {
            print("jwt yok sictik")
            return
        }
        
        WebService().getProfile(token: token) { result in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self.userProfile = profile
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

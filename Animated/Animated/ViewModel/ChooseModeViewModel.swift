//
//  ChooseModeViewModel.swift
//  Animated
//
//  Created by Mertcan Kırcı on 26.07.2023.
//

import Foundation

final class ChooseModeViewModel: ObservableObject {
    
    
    @Published var location : String = "Location"
    @Published var name : String = ""
    @Published var selectedMode: Mode = .love
    @Published var selectedGender: Gender = .male
    @Published var date = Date()
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var showingSheet: Bool = false
    @Published var didDismissed: Bool = false
    @Published var willNavigate: Bool = false
    @Published var isZodiacView: Bool = false
    @Published var timeInterval: Interval = .daily
    @Published var occupation = ""
    
    
    
    func getFortune() {
        let defaults = UserDefaults.standard
        
        guard let token = defaults.string(forKey: "jwt") else {
            print("jwt yok sictik")
            return
        }
        
        WebService().getFortune(token: token, gender: selectedGender, birthDate: date, location: location, mode: selectedMode, name: name, occupation: occupation) { result in
            switch result {
            case .success(let fortune):
                DispatchQueue.main.async {
                    print(fortune) //DispatchQueue yap veriyi cek
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

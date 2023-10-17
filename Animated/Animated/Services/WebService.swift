//
//  WebService.swift
//  Animated
//
//  Created by Mertcan Kırcı on 1.08.2023.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    var access: String?
    var refresh: String?
    var detail: String?
}

enum RegistrationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct RegisterRequestBody: Codable {
    let username: String
    let password: String
    let registerInfo: RegisterInfo

}

struct RegisterResponse: Codable {
    var access: String?
    var refresh: String?
    var detail: String?
}

struct GetProfileResponse: Codable {
    var name: String
    var sign: String
    var starMap: String
}

class WebService {
    
    //MARK: Get Profile
    
    func getProfile(token: String, completion: @escaping(Result<GetProfileResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "example.api.com/profile") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("httpResponse URL Respnonse olarak donmuyor")
                return
            }
            
            if httpResponse.statusCode == 200 {
                guard let data = data , error == nil else {
                    print(error!.localizedDescription)
                    print(completion(.failure(.noData)))
                    
                    return
                }
                
                guard let profile = try? JSONDecoder().decode(GetProfileResponse.self, from: data) else {
                    completion(.failure(.decodingError))
                    return
                }
                completion(.success(profile))
            }
            else {
                print("Http response kodu : \(httpResponse.statusCode)")
            }
            
        }
    }
    
    //MARK: Get fortune
    func getFortune(token: String, gender: Gender, birthDate: Date, location: String, mode: Mode, name: String, occupation: String, completion: @escaping (Result<GetFortuneModel,NetworkError>) -> Void) {
        
        guard let url = URL(string: "http://31.210.43.174:1337/auth/test/") else {
            completion(.failure(.invalidURL))
            return
        }
        
        
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") //MARK: Header adini memreye sor
        
        if mode == .love {
            let body = PostZodiacModel(secondUser: UserZodiacInfo(birthDay: "\(birthDate)", gender: "\(gender)", occupation: occupation, location: location, name: name), mode: .love)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        else {
            let body = PostZodiacModel(mode: mode)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidURL))
                return
            }
            
            print(httpResponse.statusCode)
            
                
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let fortune = try? JSONDecoder().decode(GetFortuneModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
                completion(.success(fortune))
            
        }.resume()
    }
    
    //MARK: Login
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError> ) -> Void) {
        
        guard let url = URL(string: "http://31.210.43.174:1337/auth/token/") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.custom(errorMessage: "zort")))
                return
            }
            
            print(httpResponse.statusCode)
            
            guard let data = data , error == nil else {
                completion(.failure(.custom(errorMessage: "No data, \(error?.localizedDescription ?? "zort")")))
                print("No data")
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Login response")))
                print("LoginResponse")
                return
            }
            
            guard let token = loginResponse.access else {
                completion(.failure(.invalidCredentials))
                print("Token yok")
                return
            }
            
            print(httpResponse.statusCode)
            print(token)
            
            completion(.success(token))
            
        }.resume()
        
    }
    
    //MARK: Register
    func register(username: String, password: String, gender: Gender, birthDate: Date, location: String, name: String, occupation: String, relationshipStatus: String, completion: @escaping (Result<String, RegistrationError>) -> Void) {
        
        guard let url = URL(string: "http://31.210.43.174:1337/auth/register/") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = RegisterRequestBody(username: username, password: password, registerInfo: RegisterInfo(zodiacInfo: UserZodiacInfo(birthDay: "\(birthDate)", gender: "\(gender)", occupation: occupation, location: location, name: name), relationshipStatus: "Evli"))
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.custom(errorMessage: "url yok")))
                return
            }
            
            print(httpResponse.statusCode)
                guard let data = data , error == nil else {
                    completion(.failure(.custom(errorMessage: "No data")))
                    print("data yok")
                    return
                }
            
                guard let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data) else {
                    completion(.failure(.invalidCredentials))
                    print("Response")
                    return
                }
                
                guard let token = registerResponse.access else {
                    print("Bulamadim tokeni")
                    return
                }
                
                completion(.success(token))
            
            
        }.resume()
    }
}

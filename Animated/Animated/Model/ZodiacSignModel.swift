//
//  UserZodiacSign.swift
//  Animated
//
//  Created by Mertcan Kırcı on 1.08.2023.
//

import Foundation

struct UserZodiacInfo: Codable {
    var birthDay: String
    var gender: String
    var occupation: String
    var location: String
    var name: String
}

struct RegisterInfo: Codable {
    var zodiacInfo: UserZodiacInfo
    var relationshipStatus: String
}

struct PostZodiacModel: Codable {
    var secondUser: UserZodiacInfo?
    var mode: Mode
}

struct GetFortuneModel: Codable {
    var userSign: String
    var seconUserSign: String? //Love modundaysa ikinci kullanicinin burcunu alalim
    var fortune: String
    var compilance: Int? //Love modundaysa uyum yuzdesi icin bi Int dondurmesi lazim
}

struct PostChatModel: Codable {
    var message: String
    var jwt: String // For users recognition
    var thread: Int //MARK: Emin degilim memreye sor
}

struct GetChatModel: Codable {
    var message: String
}



//
//  File.swift
//  pin-note
//
//  Created by Владислав Алпеев on 29.11.2020.
//

struct User {
    let phone: String
    let verificationID: String
    let code: String
}

enum NetworkErrors {
    case noConnection
    case invalidPhone
    case invalidCode
}

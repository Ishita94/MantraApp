//
//  GeneralEnumerations.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-01.
//

import Foundation

enum LoginError: LocalizedError {
    case invalidEmail
    case wrongPasswordorEmail
    case userNotFound
    case networkIssue
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email address."
        case .wrongPasswordorEmail:
            return "The email or password you entered is incorrect."
        case .userNotFound:
            return "No account exists with this email."
        case .networkIssue:
            return "Please check your internet connection."
        case .unknown:
            return "Something went wrong. Please try again."
        }
    }
}


enum Season {
  case spring, summer, autumn, winter
}

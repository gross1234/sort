//
//  UserProfile.swift
//  Sort10.4
//
//  Created by Gabe Ross on 10/4/25.
//

import Foundation

struct UserProfile {
    var id: UUID
    var phoneNumber: String
    var username: String
    var profileImageURL: String?
    var gender: Gender?
    var dateOfBirth: Date?
    var phone: String?
    var selectedProperty: String?
    var hasReligiousAssociation: Bool
    var onboardingCompleted: Bool
    
    init() {
        self.id = UUID()
        self.phoneNumber = ""
        self.username = ""
        self.profileImageURL = nil
        self.gender = nil
        self.dateOfBirth = nil
        self.phone = nil
        self.selectedProperty = nil
        self.hasReligiousAssociation = false
        self.onboardingCompleted = false
    }
}

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
    case preferNotToSay = "Prefer not to say"
}

struct Property: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let address: String
}

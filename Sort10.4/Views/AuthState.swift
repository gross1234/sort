//
//  AuthState.swift
//  Sort10.4
//
//  Created by Gabe Ross on 10/4/25.
//

import Foundation

enum AuthState {
    case initial
    case phoneNumberEntered
    case otpSent
    case otpVerified
    case profileSetup
    case onboardingComplete
}

class AuthenticationManager: ObservableObject {
    @Published var currentState: AuthState = .initial
    @Published var phoneNumber: String = ""
    @Published var countryCode: String = "+1"
    @Published var otpCode: String = ""
    @Published var userProfile: UserProfile = UserProfile()
    
    func sendOTP() {
        // Simulate OTP sending
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.currentState = .otpSent
        }
    }
    
    func verifyOTP() -> Bool {
        // Simulate OTP verification (accept any 4-digit code for demo)
        let isValid = otpCode.count == 4
        if isValid {
            currentState = .otpVerified
        }
        return isValid
    }
    
    func completeProfileSetup() {
        userProfile.phoneNumber = "\(countryCode) \(phoneNumber)"
        currentState = .profileSetup
    }
    
    func finishOnboarding() {
        userProfile.onboardingCompleted = true
        currentState = .onboardingComplete
    }
}

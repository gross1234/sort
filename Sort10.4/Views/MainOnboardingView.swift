//
//  MainOnboardingView.swift
//  Sort10.4
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct MainOnboardingView: View {
    @StateObject private var authManager = AuthenticationManager()
    
    var body: some View {
        NavigationView {
            Group {
                switch authManager.currentState {
                case .initial:
                    PhoneAuthView()
                        .environmentObject(authManager)
                case .otpSent:
                    OTPVerificationView()
                        .environmentObject(authManager)
                case .otpVerified:
                    ProfileSetupView()
                        .environmentObject(authManager)
                case .profileSetup:
                    InterestSelectionView()
                        .environmentObject(authManager)
                case .onboardingComplete:
                    MainAppView()
                        .environmentObject(authManager)
                default:
                    PhoneAuthView()
                        .environmentObject(authManager)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: authManager.currentState)
        }
        .environmentObject(authManager)
    }
}

struct MainAppView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        VStack {
            Text("Welcome to Sort!")
                .font(.largeTitle)
                .padding()
            
            Text("Your onboarding is complete!")
                .foregroundColor(.gray)
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Profile Information:")
                    .font(.headline)
                    .padding(.top)
                
                Text("Username: \(authManager.userProfile.username)")
                Text("Phone: \(authManager.userProfile.phoneNumber)")
                if let gender = authManager.userProfile.gender {
                    Text("Gender: \(gender.rawValue)")
                }
                if let property = authManager.userProfile.selectedProperty {
                    Text("Property: \(property)")
                }
                Text("Religious Association: \(authManager.userProfile.hasReligiousAssociation ? "Yes" : "No")")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding()
            
            Button("Reset Onboarding") {
                authManager.currentState = .initial
                authManager.userProfile = UserProfile()
            }
            .padding()
            .background(Color.red.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationTitle("Main App")
    }
}

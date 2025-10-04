//
//  OTPVerificationView.swift
//  Sort10.4
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct OTPVerificationView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var otpCode: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            // Header with back button
            HStack {
                Button(action: {
                    authManager.currentState = .initial
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // Illustration
            VStack {
                // Simplified hands holding phone illustration
                VStack {
                    Rectangle()
                        .fill(Color.skin)
                        .frame(width: 120, height: 20)
                        .cornerRadius(10)
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.8))
                        .frame(width: 60, height: 100)
                        .cornerRadius(8)
                    
                    Rectangle()
                        .fill(Color.skin)
                        .frame(width: 80, height: 15)
                        .cornerRadius(7)
                }
                
                // Map with red pin
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 60, height: 80)
                        .cornerRadius(8)
                    
                    VStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 2)
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 35, height: 2)
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 30, height: 2)
                    }
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                        .offset(x: 10, y: -10)
                }
            }
            .padding(.top, 40)
            
            // Title
            Text("OTP Verification")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            // Description
            Text("Enter the OTP sent to your mobile number")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            // OTP input field
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(.gray)
                
                TextField("enter code", text: $otpCode)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal, 20)
            
            // Resend code
            Button("Resend Code") {
                authManager.sendOTP()
            }
            .foregroundColor(.gray)
            
            Spacer()
            
            // Continue button
            Button(action: {
                if authManager.verifyOTP() {
                    authManager.completeProfileSetup()
                }
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.gray)
                    .cornerRadius(25)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 40)
        }
        .background(Color.white)
#if os(iOS)
        .navigationBarHidden(true)
        #endif
        .onAppear {
            authManager.otpCode = otpCode
        }
        .onChange(of: otpCode) { _, newValue in
            authManager.otpCode = newValue
        }
    }
}

extension Color {
    static let skin = Color(red: 0.9, green: 0.9, blue: 0.85)
}

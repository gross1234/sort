//
//  PhoneAuthView.swift
//  Sort10.4
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct PhoneAuthView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var phoneNumber: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Header illustration with women having coffee
            ZStack {
                Rectangle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 400)
                
                // Simplified illustration of women having coffee
                VStack {
                    HStack {
                        // Woman on left
                        VStack {
                            Rectangle()
                                .fill(Color.yellow)
                                .frame(width: 60, height: 80)
                                .cornerRadius(8)
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 60, height: 40)
                        }
                        
                        Spacer().frame(width: 20)
                        
                        // Table with mugs
                        VStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 100, height: 10)
                            
                            HStack(spacing: 10) {
                                Circle()
                                    .fill(Color.yellow)
                                    .frame(width: 30, height: 30)
                                Circle()
                                    .fill(Color.yellow)
                                    .frame(width: 30, height: 30)
                            }
                        }
                        
                        // Woman on right
                        VStack {
                            Rectangle()
 .fill(Color.blue)
                                .frame(width: 60, height: 80)
                                .cornerRadius(8)
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 60, height: 40)
                        }
                    }
                    
                    // Floating elements
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Image(systemName: "heart.arrow")
                            .foregroundColor(.pink)
                    }
                    .font(.title2)
                    .opacity(0.8)
                }
            }
            
            // Main content
            VStack(spacing: 30) {
                Spacer().frame(height: 40)
                
                // Title
                Text("User Login / Sign up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                // Terms and privacy
                VStack(spacing: 5) {
                    Text("by continuing you agree to Sort's")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    HStack(spacing: 20) {
                        Button("terms & conditions") {
                            // Handle terms
                        }
                        .foregroundColor(.gray)
 .underline()
                        
                        Button("privacy policy") {
                            // Handle privacy policy
                        }
                        .foregroundColor(.gray)
                        .underline()
                    }
                    .font(.caption)
                }
                
                Spacer().frame(height: 40)
                
                // Phone number input
                HStack {
                    // Country code selector (simplified)
                    HStack {
                        Text("🇺🇸")
                            .font(.title2)
                        Text("+1")
                        Image(systemName: "chevron.down")
                            .font(.caption)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 15)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    VStack {
                        TextField("Enter your phone number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 8)
                        
                        Button(action: {
                            authManager.phoneNumber = phoneNumber
                            authManager.sendOTP()
                        }) {
                            Text("Send OTP")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(phoneNumber.count >= 10 ? Color.blue : Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(phoneNumber.count < 10)
                        .padding(.horizontal, 8)
                        .padding(.top, 10)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(Color.white)
        }
        .background(Color.white)
#if os(iOS)
        .navigationBarHidden(true)
        #endif
    }
}

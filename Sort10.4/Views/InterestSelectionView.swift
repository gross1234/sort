//
//  InterestSelectionView.swift
//  Sort10.4
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct InterestSelectionView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with back button
            HStack {
                Button(action: {
                    authManager.currentState = .profileSetup
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                        Text("Back")
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // Filter illustration
            VStack {
                Spacer()
                
                // 3D filter illustration
                ZStack {
                    // Blue top part of filter
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 200, height: 80)
                            .cornerRadius(15)
                        
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 150, height: 60)
                    }
                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    // Red spout part
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 80, height: 40)
                        
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 60, height: 20)
                            .cornerRadius(10)
                        
                        // Diagonal cut effect
                        Path { path in
                            path.move(to: CGPoint(x: 60, y: 60))
                            path.addLine(to: CGPoint(x: 0, y: 50))
                            path.addLine(to: CGPoint(x: 0, y: 60))
                            path.closeSubpath()
                        }
                        .fill(Color.red)
                        .frame(width: 60, height: 10)
                    }
                    .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                
                Spacer()
            }
            .frame(height: 300)
            .padding(.horizontal, 40)
            
            VStack(spacing: 20) {
                Spacer()
                
                // Primary action button
                Button(action: {
                    // Start full onboarding process
                    startFullOnboarding()
                }) {
                    Text("Choose event interests takes 5 min")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .background(Color.gray)
                        .cornerRadius(25)
                }
                .padding(.horizontal, 20)
                
                // Skip onboarding button
                Button(action: {
                    // Skip to main app
                    skipOnboarding()
                }) {
                    Text("Skip onboarding")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(25)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.bottom, 50)
        }
        .background(Color.white)
#if os(iOS)
        .navigationBarHidden(true)
        #endif
    }
    
    private func startFullOnboarding() {
        // This would navigate to event interest selection screens
        // For now, we'll just complete onboarding
        authManager.finishOnboarding()
    }
    
    private func skipOnboarding() {
        authManager.finishOnboarding()
    }
}

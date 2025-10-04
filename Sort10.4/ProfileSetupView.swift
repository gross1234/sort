//
//  ProfileSetupView.swift
//  Sort10.4
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct ProfileSetupView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var username: String = ""
    @State private var selectedGender: Gender?
    @State private var dateOfBirth: Date = Date()
    @State private var phone: String = ""
    @State private var selectedProperty: String = ""
    @State private var hasReligiousAssociation: Bool = false
    @State private var profileImage: Image?
    
    let sampleProperties = [
        "Downtown Luxury Apartments",
        "Riverside Lofts",
        "Garden View Condos",
        "Central Plaza Residence",
        "City Heights Complex"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Pink header section
            ZStack {
                Rectangle()
                    .fill(Color.pink)
                    .cornerRadius(20)
                
                VStack {
                    // Back button
                    HStack {
                        Button(action: {
                            authManager.currentState = .otpVerified
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
                    
                    Spacer()
                    
                    // Title
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Set up your profile.")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Upload your profile picture below.")
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                .padding(20)
            }
            .frame(height: 180)
            
            ScrollView {
                VStack(spacing: 25) {
                    // Profile picture upload
                    Button(action: {
                        // Handle image upload
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 120, height: 120)
                            
                            if let profileImage = profileImage {
                                profileImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                            } else {
                                VStack {
                                    Image(systemName: "photo")
                                        .foregroundColor(.white)
                                        .font(.system(size: 30))
                                    
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                        .offset(x: 30, y: -10)
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                    
                    // Form fields
                    VStack(spacing: 20) {
                        // Username field
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.black)
                                .frame(width: 20)
                            
                            TextField("Enter username", text: $username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Gender field
                        HStack {
                            Image(systemName: "person.2.fill")
                                .foregroundColor(.black)
                                .frame(width: 20)
                            
                            Menu {
                                ForEach(Gender.allCases, id: \.self) { gender in
                                    Button(gender.rawValue) {
                                        selectedGender = gender
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(selectedGender?.rawValue ?? "Gender")
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        
                        // Date of birth field
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.black)
                                .frame(width: 20)
                            
                            DatePicker("Date of birth (optional)", 
                                     selection: $dateOfBirth, 
                                     displayedComponents: .date)
                                .labelsHidden()
                        }
                        
                        // Continue button (placed here as shown in image)
                        Button(action: {
                            completeProfileSetup()
                        }) {
                            Text("Continue")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(Color.gray)
                                .cornerRadius(25)
                        }
                        .disabled(username.isEmpty)
                        
                        // Phone field
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.black)
                                .frame(width: 20)
                            
                            TextField("Phone (optional)", text: $phone)
                                .keyboardType(.phonePad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Select property field
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(.black)
                                .frame(width: 20)
                            
                            Menu {
                                ForEach(sampleProperties, id: \.self) { property in
                                    Button(property) {
                                        selectedProperty = property
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(selectedProperty.isEmpty ? "Select property" : selectedProperty)
                                        .foregroundColor(selectedProperty.isEmpty ? .gray : .black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.black)
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        
                        // Religious association
                        HStack {
                            Image(systemName: "book.fill")
                                .foregroundColor(.black)
                                .frame(width: 20)
                            
                            HStack {
                                Text("Do you have a religious association?")
                                Toggle("", isOn: $hasReligiousAssociation)
                                    .toggleStyle(SwitchToggleStyle())
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .background(Color.white)
#if os(iOS)
        .navigationBarHidden(true)
        #endif
    }
    
    private func completeProfileSetup() {
        authManager.userProfile.username = username
        authManager.userProfile.gender = selectedGender
        authManager.userProfile.dateOfBirth = dateOfBirth
        authManager.userProfile.phone = phone.isEmpty ? nil : phone
        authManager.userProfile.selectedProperty = selectedProperty.isEmpty ? nil : selectedProperty
        authManager.userProfile.hasReligiousAssociation = hasReligiousAssociation
        
        authManager.currentState = .profileSetup
    }
}


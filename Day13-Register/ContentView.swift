//
//  ContentView.swift
//  Day13-Register
//
//  Created by Beatriz Cardozo on 15/8/24.
//

import SwiftUI

struct ContentView: View {
    
    //State Variables
    @State private var isShowingPassword: Bool = false
    @ObservedObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 30){
            
            //Title
            Text("Sign Up")
                .font(.custom("Poppins", size: 30))
                .fontWeight(.black)
                .foregroundStyle(.black)
            
            //Username
            VStack (alignment: .leading){
                LabelTextView(labelText: "Username")
                FormView(fieldName: "", fieldValue: $viewModel.username)
                RequirementText(
                    iconName: viewModel.isUsernameLengthValid ? "checkmark.circle.fill" : "xmark.circle.fill",
                    iconColor: viewModel.isUsernameLengthValid ? .green : Color(red: 250/255, green: 135/255, blue: 135/255),
                    requirementText: "Mínimo 6 carácteres",
                    isVerified: viewModel.isUsernameLengthValid)
                    .padding(.vertical, 5)
            }
            
            
            //Password
            VStack (alignment: .leading){
                HStack {
                    LabelTextView(labelText: "Password")
                    Spacer()
                    showPasswordButton(showPassword: $isShowingPassword)
                }
                .padding(.horizontal, 5)
                
                if(isShowingPassword){
                    FormView(fieldName: "", fieldValue: $viewModel.password, isSecure: false)
                } else {
                    FormView(fieldName: "", fieldValue: $viewModel.password, isSecure: true)
                }
                //TODO: change icon to check when is true
                VStack {
                    RequirementText(
                        iconName: viewModel.isPasswordLengthValid ? "checkmark.circle.fill" : "xmark.circle.fill",
                        iconColor: viewModel.isPasswordLengthValid ? .green : Color(red: 250/255, green: 135/255, blue: 135/255),
                        requirementText: "Mínimo 8 carácteres",
                        isVerified: viewModel.isPasswordLengthValid)
                    
                    RequirementText(
                        iconName: viewModel.isPasswordCapitalValid ? "checkmark.circle.fill" : "xmark.circle.fill",
                        iconColor: viewModel.isPasswordCapitalValid ? .green : Color(red: 250/255, green: 135/255, blue: 135/255),
                        requirementText: "Una mayúscula",
                        isVerified: viewModel.isPasswordCapitalValid)
                }.padding(.vertical, 8)
                
            }
            
            
           //Verify password
            VStack (alignment: .leading){
                HStack {
                    LabelTextView(labelText: "Verify Password")
                    Spacer()
                    showPasswordButton(showPassword: $isShowingPassword)
                }
                .padding(.horizontal, 5)
                
                if(isShowingPassword){
                    FormView(fieldName: "", fieldValue: $viewModel.passwordValidation, isSecure: false)
                } else {
                    FormView(fieldName: "", fieldValue: $viewModel.passwordValidation, isSecure: true)
                }
                //TODO: change icon to check when is true
                RequirementText(
                    iconName: viewModel.isPasswordConfirmedValid ? "checkmark.circle.fill" : "xmark.circle.fill",
                    iconColor: viewModel.isPasswordConfirmedValid ? .green : Color(red: 250/255, green: 135/255, blue: 135/255),
                    requirementText: viewModel.isPasswordConfirmedValid  ? "Las contraseñas coinciden": "Las contraseñas no coinciden",
                    isVerified: viewModel.isPasswordConfirmedValid)
                    .padding(.vertical, 5)
            }
    
           //Button to sign in
            Button{
                //TODO: funcionality
            } label: {
                Text("SIGN UP")
                            .font(.custom("Poppins", size: 16))
                            .fontWeight(.bold)
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(20)
            }
            
            HStack (alignment: .center){
                Spacer()
                Text("Already have an account?")
                    .font(.custom("Poppins", size: 14))
                    .foregroundStyle(.black)
                    .fontWeight(.regular)
                
                Button{
                    //TODO: redirect to login page
                } label: {
                    Text("Sign In")
                        .font(.custom("Poppins", size: 14))
                        .foregroundStyle(.black)
                        .fontWeight(.black)
                }
                Spacer()
                
            }.padding(.horizontal, 10)
        }
        .padding(50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    LinearGradient(colors: [.purple, .white, .white, .white, .white, .purple], startPoint: .bottom, endPoint: .top)
                        .ignoresSafeArea()
                }
    }
}

struct RequirementText: View { //Validation
    
    //Variables
    var iconName = "xmark.circle.fill"
    var iconColor = Color(red: 250/255, green: 135/255, blue: 135/255)
    var requirementText = ""
    var isVerified = false
    
    var body: some View {
        HStack (spacing: 10){
            Image(systemName: iconName)
                .foregroundStyle(iconColor)
            
            Text(requirementText)
                .font(.custom("Poppins", size: 13))
                .foregroundStyle(.secondary)
                //.strikethrough(isVerified) //if isVerified is true
            
            Spacer()
            
        }
    }
}

struct FormView: View {
    
    var fieldName = ""
    @Binding var fieldValue: String
    var isSecure = false
    
    var body: some View {
        VStack {
            if isSecure {
                SecureField(fieldName, text: $fieldValue)
                    .font(.custom("Poppins", size: 14))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 18)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.purple, lineWidth: 2)
                    )
            } else {
                TextField(fieldName, text: $fieldValue)
                    .font(.custom("Poppins", size: 14))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 18)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.purple, lineWidth: 2)
                    )
            }
        }
    }
}

struct LabelTextView: View {
    
    var labelText: String
    
    var body: some View {
        Text(labelText)
            .font(.custom("Poppins", size: 16))
            .foregroundStyle(.secondary)
    }
}

struct showPasswordButton: View {
    
    @Binding var showPassword: Bool
    
    var body: some View {
        Button{
            self.showPassword.toggle()
        } label : {
            Image(systemName: "eye.fill")
                .foregroundStyle(.purple)
                .font(.system(size: 15))
        }
    }
}

#Preview {
    ContentView()
}





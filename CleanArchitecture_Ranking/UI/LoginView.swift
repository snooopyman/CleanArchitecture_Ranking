//
//  LoginView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @Environment(AppState.self) private var appState
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .overlay {
                        Image(systemName: "dog.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.purple)
                    }
                    .clipped()
                    .shadow(color: .purple, radius: 8)
                    .padding(.top, 30)
                
                VStack(spacing: 28) {
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .background(.gray.opacity(0.1))
                        .clipShape(.buttonBorder)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2), lineWidth: 1))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .clipShape(.buttonBorder)
                        .background(.gray.opacity(0.1))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2), lineWidth: 1))
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                }
                .padding(.top, 40)
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
//                        RecoverPasswordView()
                    } label: {
                        Text("Did you forget your password?")
                            .font(.footnote)
                            .foregroundColor(.purple)
                            .underline(color: .purple)
                    }
                }
                
                VStack(spacing: 15) {
                    Button(action: {
                        Task {
                            await viewModel.login()
                            await appState.checkUserStatus()
                        }
                    }) {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.black)
                            )
                            .foregroundColor(.white)
                    }
                    
                    NavigationLink {
                        // RegisterView()
                        // .navigationBarBackButtonHidden()
                    } label: {
                        Text("Create account")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.black, lineWidth: 1)
                            )
                            .foregroundColor(.black)
                    }
                }
                .padding(.top, 30)
                
                LabelledDivider(label: "Log In with")
                    .padding(.top, 40)
                
                HStack(spacing: 10) {
                    Button(action: {
                        Task {
//                            await viewModel.loginWithGoogle()
//                            await appState.checkUserStatus()
                        }
                    }) {
                        Image(systemName: "playstation.logo")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
//                        viewModel.loginWithApple
//                        await appState.checkUserStatus()
                    }) {
                        Image(systemName: "apple.logo")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.horizontal, 28)
        }
    }
}

#Preview {
    LoginView()
        .environment(AppState())
}

struct LabelledDivider: View {
    
    let label: String
    let horizontalPadding: CGFloat
    let color: Color
    
    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }
    
    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }
    
    var line: some View {
        VStack {
            Divider().background(color)
        }
        .padding(horizontalPadding)
    }
}

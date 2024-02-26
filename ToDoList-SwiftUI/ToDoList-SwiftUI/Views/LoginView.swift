//
//  LoginView.swift
//  ToDoList-SwiftUI
//
//  Created by Sillas Santos on 13/06/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "To Do List",
                           subtitle: "Get Things Done",
                           angle: 15,
                           background: .pink)
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.none)
                    
                    TLButton(title: "Log In",
                             background: .blue
                    ) {
                        viewModel.login()
                    }
                    .padding()
                }
                VStack{
                    Text("New around here ?")
                    NavigationLink("Create An Account",
                                   destination: RegisterView()
                    )
                    .padding(.bottom, 50)
                }
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

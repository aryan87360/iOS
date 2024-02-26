//
//  RegistreView.swift
//  ToDoList-SwiftUI
//
//  Created by Sillas Santos on 13/06/23.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack {
            HeaderView(title: "Register",
                       subtitle: "Start organizing",
                       angle: -15,
                       background: .orange)
            .offset(y: -40)
            Form {
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.none)
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.none)
                
                TLButton(title: "Create", background: .green) {
                    viewModel.register()
                }
                .padding()
            }
        }
    }
}

struct RegistreView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

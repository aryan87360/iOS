//
//  EditAccountView.swift
//  Password Manager
//
//  Created by Aryan Sharma on 02/05/24.
//

import SwiftUI
import CoreData
import CryptoKit

struct EditAccountView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var showingEditForm: Bool
    let passwordEntity: Password // CoreData Password entity

    @State private var accountType = ""
    @State private var username = ""
    @State private var passwordText = ""
    @State private var isPasswordVisible = false
    @State private var passwordStrength: PasswordStrength? = nil
    @State private var showingAlert = false

    let keyManager = KeyManager()
    var key: SymmetricKey {
        keyManager.getKey()
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("Account Type", text: $accountType)
                    .padding()
                    .background(
                        RoundedRectangle(
                            cornerRadius: 15)
                        .fill(Color(red: 255/255, green: 255/255, blue: 255/255)))
                    .frame(width: 350, height: 30)
                    .padding()
                TextField("Username", text: $username)
                    .padding()
                    .background(
                        RoundedRectangle(
                            cornerRadius: 15)
                        .fill(Color(red: 255/255, green: 255/255, blue: 255/255)))
                    .frame(width: 350, height: 30)
                    .padding()

                ZStack(alignment: .trailing) {
                    if isPasswordVisible {
                        TextField("Password", text: $passwordText)
                    } else {
                        SecureField("Password", text: $passwordText)
                    }
                    
                    HStack {
                        Button(action: {
                            self.passwordText = generatePassword()
                        }) {
                            Image(systemName: "key.fill")
                                .foregroundColor(Color.blue)
                        }
                        .padding(.trailing, 5)
                        
                        Button(action: {
                            self.isPasswordVisible.toggle()
                        }) {
                            Image(systemName: self.isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.isPasswordVisible ? Color.gray : Color.blue)
                        }
                    }
                    .padding(.trailing, 15)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(passwordText.isEmpty ? Color.gray : passwordStrength?.color ?? Color.gray, lineWidth: 2)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                )
                .frame(maxWidth: .infinity)
                .padding()
                .onChange(of: passwordText) { newValue in
                    passwordStrength = newValue.isEmpty ? nil : PasswordChecker().checkStrength(of: newValue)
                }

                Button(action: {
                    if self.accountType.isEmpty || self.username.isEmpty || self.passwordText.isEmpty {
                        self.showingAlert = true
                    } else {
                        self.saveChanges()
                    }
                }) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(15)
                }
                .padding()
            }
            .background(Color(red: 249/255, green: 249/255, blue: 249/255))
        }
        .presentationDetents([.height(350), .height(550)])
        .onAppear {
            self.accountType = self.passwordEntity.accountType ?? ""
            self.username = self.passwordEntity.username ?? ""
            
            if let passwordData = Data(base64Encoded: self.passwordEntity.password ?? "") {
                let sealedBox = try! AES.GCM.SealedBox(combined: passwordData)
                let decryptedData = try! AES.GCM.open(sealedBox, using: self.key)
                self.passwordText = String(decoding: decryptedData, as: UTF8.self)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Missing Information"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))
        }
    }

    func generatePassword() -> String {
        let length = 12
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()"
        return String((0..<length).map{ _ in characters.randomElement()! })
    }
    
    func saveChanges() {
        self.passwordEntity.accountType = self.accountType
        self.passwordEntity.username = self.username
        
        let passwordData = Data(self.passwordText.utf8)
        let sealedBox = try! AES.GCM.seal(passwordData, using: self.key)
        let passwordBase64 = sealedBox.combined!.base64EncodedString()
        self.passwordEntity.password = passwordBase64

        do {
            try self.managedObjectContext.save()
            self.showingEditForm = false
        } catch {
            print("core data error in editaccountview")
        }
    }
}

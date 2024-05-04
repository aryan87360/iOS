//
//  ContentView.swift
//  Password Manager
//
//  Created by Aryan Sharma on 02/05/24.
//

import SwiftUI
import CoreData

struct HomeScreen: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Password.entity(),
        sortDescriptors: []
    ) var passwords: FetchedResults<Password>
    @State private var showingForm = false
    @State private var showingDetail = false
    @State private var selectedPassword: Password?

    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    ForEach(passwords, id: \.id) { password in
                        Capsule()
                            .fill(Color(red: 249/255, green: 240/255, blue: 249/255))
                            .frame(width: 350, height: 60)
                            .overlay(
                                HStack {
                                    Text("\(password.accountType ?? "Unknown") ******")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Spacer(minLength: 5)
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundColor(.black)
                                .padding([.leading, .top, .bottom, .all])
                            )
                            .padding(.bottom, 10)
                            .onTapGesture {
                                self.selectedPassword = password
                                self.showingDetail = true
                            }
                        
                    }
                }
                .navigationBarTitle("Password Manager")
                .sheet(isPresented: $showingForm) {
                    Addnew(showingForm: $showingForm)
                }
                .sheet(item: $selectedPassword) { selectedPassword in
                    PasswordDetailView(showingDetail: $showingDetail, password: selectedPassword)
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.showingForm = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title.weight(.semibold))
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4, x: 0, y: 4)
                    }
                    .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

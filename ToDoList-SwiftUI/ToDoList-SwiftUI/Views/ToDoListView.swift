//
//  ToDoItemListView.swift
//  ToDoList-SwiftUI
//
//  Created by Sillas Santos on 13/06/23.
//
import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    
    @StateObject var viewModel : ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                 List(items) { items in
                    ToDoListItemView(item: items)
                         .swipeActions {
                             Button("Delete") {
                                 viewModel.delete(id: items.id)
                             }.tint(Color.red)
                         }
                 }
                 .listStyle(PlainListStyle())
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "G7bSgsf2FNUf3FTDBxq47vCpysr2")
    }
}



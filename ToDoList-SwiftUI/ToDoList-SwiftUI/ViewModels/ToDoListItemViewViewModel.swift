//
//  ContentView.swift
//  ToDoList-SwiftUI
//
//  Created by Aryan Sharma on 13/10/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TodoListItemViewViewModel: ObservableObject {
    
    init() {}
    
    func toogleIsDone(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
        db.collection("todos")
        db.document(itemCopy.id)
            .setData(itemCopy.asDictonary())
    }
}

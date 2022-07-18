//
//  HistoryView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 7/7/22.
//

import Foundation
import FirebaseFirestore

class HistoryModel: ObservableObject {
    @Published var list = [wordData]()
    
    // MARK: - Getting data from Firestore database
    func getData() {
        // Get a reference to the database
        
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
                db.collection("SinglishVocabulary").getDocuments { snapshot, error in
                    
                    // Check for errors
                    if error == nil {
                        // No errors
                        
                        if let snapshot = snapshot {
                            
                            // Update the list property in the main thread
                            DispatchQueue.main.async {
                                
                                // Get all the documents and create Todos
                                self.list = snapshot.documents.map { d in
                                    
                                    // Create a wordData item for each document returned
                                    return wordData(id: d.documentID,
                                                word: d["word"] as? String ?? "",
                                                description: d["description"] as? String ?? "")
                                }
                            }
                            
                            
                        }
                    }
                    else {
                        // Handle the error
                    }
                }
    }
            
}


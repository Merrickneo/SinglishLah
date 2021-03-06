//
//  HistoryView.swift
//  SinglishLah
//
//  Created by Merrick Neo on 7/7/22.
//
import Foundation
import FirebaseFirestore

class WordDatabase: ObservableObject {
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
                                                description: d["description"] as? String ?? "",
                                                example: d["example"] as? String ?? "",
                                                searched: d["searched"] as? Bool ?? false)
                                }
                            }
                            
                            
                        }
                    }
                    else {
                        // Handle the error
                    }
                }
    }
    func toggleWordSearched(word: wordData) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Update the searched field in the database
        
        // Create a reference to the SinglishVocabulary collection
        let singlishVocabularyRef = db.collection("SinglishVocabulary").document(word.id)
        
        singlishVocabularyRef.updateData([
            "searched": true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
}

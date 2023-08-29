//
//  UserViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이희찬 on 2023/08/26.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    private var db = Firestore.firestore()
    
    // Create
    func createUser(user: User) {
        do {
            let _ = try db.collection("users").addDocument(from: user)
        } catch let error {
            print("Error creating user: \(error)")
        }
    }
    
    // Read
    func fetchUser(userId: String) {
        db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let result = Result {
                    try document.data(as: User.self)
                }
                switch result {
                    case .success(let user):
                        self.user = user
                    
                    case .failure(let error):
                        print("Error decoding user: \(error)")
                }
            }
        }
    }
    
    // Update
    func updateUser(user: User) {
        if let userId = user.id {
            do {
                try db.collection("users").document(userId).setData(from: user)
            } catch let error {
                print("Error updating user: \(error)")
            }
        }
    }
}

extension UserViewModel {
    func followUser(targetUserId: String) {
        if let currentUserId = Auth.auth().currentUser?.uid{
            db.collection("users").document(currentUserId).updateData([
                "following": FieldValue.arrayUnion([targetUserId])
            ])
            
            
            db.collection("users").document(targetUserId).updateData([
                "follower": FieldValue.arrayUnion([currentUserId])
            ])
        }
    }
    
    func unfollowUser(targetUserId: String) {
        if let currentUserId = Auth.auth().currentUser?.uid{
            db.collection("users").document(currentUserId).updateData([
                "following": FieldValue.arrayRemove([targetUserId])
            ])
            
            db.collection("users").document(targetUserId).updateData([
                "follower": FieldValue.arrayRemove([currentUserId])
            ])
        }
    }
    
    func fetchFollowDetails(userId: String, follow: FollowType, completion: @escaping ([User]) -> Void) {
           db.collection("users").document(userId).getDocument { (document, error) in
               if let data = document?.data(), let followingIds = data[follow.rawValue] as? [String] {
                   self.fetchUsersDetails(userIds: followingIds, completion: completion)
               } else {
                   completion([])
               }
           }
       }
    
    private func fetchUsersDetails(userIds: [String], completion: @escaping ([User]) -> Void) {
        db.collection("users").whereField(FieldPath.documentID(), in: userIds).getDocuments { (querySnapshot, error) in
            if let documents = querySnapshot?.documents {
                let users = documents.compactMap { document -> User? in
                    try? document.data(as: User.self)
                }
                completion(users)
            } else {
                completion([])
            }
        }
    }
}

enum FollowType: String {
    case following
    case follower
}

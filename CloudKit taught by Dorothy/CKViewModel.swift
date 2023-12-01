//
//  CKViewModel.swift
//  CloudKit taught by Dorothy
//
//  Created by Min Thu Khine on 12/1/23.
//

import Foundation
import CloudKit

@MainActor class CKViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    func reload() async {
        do {
            let posts = try await CloudKitService.fetch()
            self.posts = posts
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func makeNewPost(username: String, text: String) async throws {
        let newPost = Post(username: username, text: text)
        try await CloudKitService.save(newPost)
        posts.append(newPost)
    }
}

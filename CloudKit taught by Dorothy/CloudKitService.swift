//
//  CloudKitService.swift
//  CloudKit taught by Dorothy
//
//  Created by Min Thu Khine on 12/1/23.
//

import Foundation
import CloudKit

class CloudKitService {
    
    static let container = CKContainer.init(identifier: "iCloud.com.hoover.CloudKit-taught-by-Dorothy")
    static let publicDatbase = container.publicCloudDatabase
    
    static func save(_ post: Post) async throws {
        let record = post.record
        try await publicDatbase.save(record)
    }
    
    static func fetch() async throws -> [Post] {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Post", predicate: predicate)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        query.sortDescriptors = [sort]
        let result = try await publicDatbase.records(matching: query)
        let matchResults = result.matchResults
        var records = [CKRecord]()
        for matchResult in matchResults {
            let result = matchResult.1
            if let record = try? result.get() {
                records.append(record)
            }
        }
        
        var posts = [Post]()
        for record in records {
            if let post = Post(from: record) {
                posts.append(post)
            }
        }
        return posts
    }
}

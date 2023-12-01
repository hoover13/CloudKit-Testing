//
//  ContentView.swift
//  CloudKit taught by Dorothy
//
//  Created by Min Thu Khine on 12/1/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CKViewModel
    @State private var username = ""
    @State private var text = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
            TextField("Type Something...", text: $text)
                .padding()
            
            
            Button("Save Posts") {
                Task {
                    do {
                        try await viewModel.makeNewPost(username: username, text: text)
                        username = ""
                        text = ""
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Reload Posts") {
                Task {
                     await viewModel.reload()
                    
                }
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.posts) { post in
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(post.username)
                                    Text(post.creationDate.formatted())
                                    
                                }
                                Text(post.text)
                            }
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView(viewModel: CKViewModel())
}

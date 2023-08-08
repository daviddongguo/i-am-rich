//
//  NewsView.swift
//  I Am Rich
//
//  Created by david on 2023-08-07.
//

import SwiftUI

struct NewsView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)){
                HStack{
                    Text(String(post.points)).padding(15)
                Text(post.title)
                }
                }
            }
            .navigationBarTitle("H4x0R NEWS")
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
    
}


struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

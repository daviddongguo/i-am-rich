//
//  IngredientView.swift
//  I Am Rich
//
//  Created by david on 2023-08-08.
//

import SwiftUI

struct IngredientView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.ingredients) { post in
                
                HStack{
                    Text(String(post.calories)).padding(15)
                    Text(post.name)
                }
            }
            .navigationBarTitle("H4x0R NEWS")
        }
        .onAppear {
            self.networkManager.fetchIngredientData()
        }
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView()
    }
}

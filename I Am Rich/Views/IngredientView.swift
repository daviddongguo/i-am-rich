//
//  IngredientView.swift
//  I Am Rich
//
//  Created by david on 2023-08-08.
//

import SwiftUI

struct IngredientView: View {
    
    @State private var foodInputString: String = ""
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        VStack {
            TextField("Enter a food, dirnk, or ingredient", text: $foodInputString)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            Button("Submit") {
                self.networkManager.fetchIngredientData(foodInputString)
            }
            .padding().frame(width: 300, height: 200)
            
            NavigationView {
                List(networkManager.ingredients) { post in
                    HStack{
                        Text(String(post.calories)).padding(15)
                        Text(post.name)
                    }
                }
            }
        }
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView()
    }
}

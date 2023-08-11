//
//  IngredientView.swift
//  I Am Rich
//
//  Created by david on 2023-08-08.
//

import DGCharts
import SwiftUI



struct IngredientView: View {
    
    @State private var totalCalries: Int = 0
    @State private var foodInputString: String = ""
    @State private var quantities = [Int]()
    @State private var ingredientWithQuantityList = [IngredientWithQuntityViewModel]()
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        VStack {
            Text(totalCalries.formatted()).font(.system(size: 50)).fontWeight(.heavy).foregroundColor(.white).background(.red).padding(.horizontal)
            TextField("Enter a food, dirnk, or ingredient", text: $foodInputString)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            Button("Submit") {
                let array = (foodInputString + ",").split(separator: ",")
                if(!array.isEmpty){
                    quantities.removeAll()
                }
                for i in 0..<array.count {
                    quantities.append(Int(array[i].trimmingCharacters(in: .whitespaces).split(separator: " ")[0] ) ?? 1)
                }
                self.networkManager.fetchIngredientData(foodInputString)
            }
            .padding().frame(width: 300, height: 200)
            
            
            
            NavigationView {
                List(ingredientWithQuantityList.indices, id: \.self) { index in
                    HStack {
                        Text(String(ingredientWithQuantityList[index].quantity))
                        Stepper("", value: $ingredientWithQuantityList[index].quantity, in: 0...20, step: 1)
                        
                        Text(ingredientWithQuantityList[index].name)
                        
                        Text(String(format: "%.0f", ingredientWithQuantityList[index].calories ))
                        Stepper("", value: $ingredientWithQuantityList[index].calories, in: 0...200, step: 10)
                    }
                }
            }

        }
        .onChange(of: networkManager.ingredients) { ingredientsFromAPI in
            if !ingredientsFromAPI.isEmpty {
                ingredientWithQuantityList.removeAll()
                for i in 0..<ingredientsFromAPI.count {
                    let ingredientWithQuantity =  IngredientWithQuntityViewModel(
                        quantity: quantities[i],
                        calories: ingredientsFromAPI[i].calories / Float(quantities[i]),
                        name: ingredientsFromAPI[i].name)
                    ingredientWithQuantityList.append(ingredientWithQuantity)
                }
            }
        }
        .onChange(of: ingredientWithQuantityList) { ingredientsForDisplaying in
            if !ingredientsForDisplaying.isEmpty {
                totalCalries = 0
                for i in 0..<ingredientsForDisplaying.count {
                    totalCalries += ingredientsForDisplaying[i].quantity * Int(Float(ingredientsForDisplaying[i].calories ))
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

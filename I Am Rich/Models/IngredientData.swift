//
//  IngredientData.swift
//  I Am Rich
//
//  Created by david on 2023-08-08.
//

import Foundation

struct CalorieResults: Decodable {
    let items: [Ingredient]
}

struct Ingredient: Decodable, Identifiable {
    var id: String {
        return randomString(16)
    }
    let name: String
    let calories: Float
}


func randomString(_ length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in letters.randomElement()! })
}

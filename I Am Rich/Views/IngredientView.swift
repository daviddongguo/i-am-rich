//
//  IngredientView.swift
//  I Am Rich
//
//  Created by david on 2023-08-08.
//

import DGCharts
import SwiftUI
import RealmSwift


struct IngredientView: View {
    
    
    
    @State private var dateTimeCalories : [DateTimeCalorie] = [
        DateTimeCalorie(dateTime: DateTimeCalorie.parseDate("2023-08-3 07:30"), calories: 1200.0),
        DateTimeCalorie(dateTime: DateTimeCalorie.parseDate("2023-08-4 07:30"), calories: 1200.0),
        DateTimeCalorie(dateTime: DateTimeCalorie.parseDate("2023-08-5 07:30"), calories: 1200.0),
        DateTimeCalorie(dateTime: DateTimeCalorie.parseDate("2023-08-6 07:30"), calories: 1200.0),
        DateTimeCalorie(dateTime: DateTimeCalorie.parseDate("2023-08-7 07:30"), calories: 1200.0),
    ]
    
    @State private var selectedDate = Date()
    @State private var isDatePickerVisible = false
    
    
    @State private var totalCalries: Double = 50.0
    @State private var foodInputString: String = ""
    @State private var quantities = [Int]()
    @State private var ingredientWithQuantityList = [IngredientWithQuntityViewModel]()
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                isDatePickerVisible.toggle()
            }) {
                Image(systemName: "calendar")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $isDatePickerVisible, content: {
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .navigationBarItems(trailing: Button("Done") {
                        isDatePickerVisible = false
                    })
                
            }) //: end of Button
            Text("\(selectedDate, formatter: dateFormatter)")
                .padding()
            
            Text(totalCalries.formatted()).font(.system(size: 50)).fontWeight(.heavy).foregroundColor(.white).background(.red).padding(.horizontal)
            
            Slider(value: $totalCalries, in: 0...1200, step: 10)
                .padding()
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
            .padding()
            
            Button("Save") {
                let currentDateTimeCalorie = DateTimeCalorie(dateTime: selectedDate, calories: Double(totalCalries))
                dateTimeCalories.append(currentDateTimeCalorie)
                // save on database
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(currentDateTimeCalorie)
                    }
                    print(Realm.Configuration.defaultConfiguration.fileURL)
                } catch {
                    print("Error initialising new real, \(error)")
                }
                
            }.padding()
            
            
            
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
                    totalCalries += Double(ingredientsForDisplaying[i].quantity) * (Double(ingredientsForDisplaying[i].calories ))
                }
            }
        }
        
        DailyCalorieGraph(entries: DateTimeCalorie.dataEntries(dateTimeCalories))
            .onAppear {
                do {
                    let realm = try Realm()
                    let results = realm.objects(DateTimeCalorie.self)
                    
                    dateTimeCalories.removeAll()
                    for result in results {
                        dateTimeCalories.append(result)
                    }
                    
                } catch {
                    print("\(error)")
                }
            }
        
    } //: end of Body
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView()
    }
}

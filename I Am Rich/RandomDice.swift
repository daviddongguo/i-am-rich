//
//  RandomDice.swift
//  I Am Rich
//
//  Created by david on 2023-08-07.
//

import SwiftUI

struct RandomDice: View {

    @State var n1 = 1
    @State var n2 = 2
    func roll() {
        n1 = Int.random(in: 1...6)
        n2 = Int.random(in: 1...6)
    }
    var body: some View {
        ZStack {
            Image("background").resizable().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Image("diceeLogo")
                Spacer()
                HStack{
                    DiceImage(n: n1)
                    DiceImage(n: n2)
                }.padding(.horizontal)
                Spacer()
                Button(action: roll){
                    Text("Roll").font(.system(size: 50)).fontWeight(.heavy).foregroundColor(.white).background(.red).padding(.horizontal)
                }
                
                
            }
            .padding()
        }
    }

}

struct RandomDice_Previews: PreviewProvider {
    static var previews: some View {
        RandomDice()
    }
}

struct DiceImage: View {
    let n: Int
    var body: some View {
        Image("dice\(n)").resizable().aspectRatio(1, contentMode: .fit)
    }
}

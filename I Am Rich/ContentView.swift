//
//  ContentView.swift
//  I Am Rich
//
//  Created by david on 2023-08-07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Value for Key 'Name': \(getValueForKey(key: "apikey") ?? "N/A")")
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct ImageView: View {
    let imageName: String
    var body: some View {
        Image(imageName).resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 150).padding(15) .clipShape(Circle()).overlay(Circle().stroke(Color.white, lineWidth: 5))
    }
}

struct TextView: View {
    var body: some View {
        Text("I am rich")
            .font(.system(size: 60))
            .fontWeight(.bold)
    }
}



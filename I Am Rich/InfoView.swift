//
//  InfoView.swift
//  I Am Rich
//
//  Created by david on 2023-08-07.
//

import SwiftUI

struct InfoView: View {
    let text: String
    let imageName: String
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(height: 50)
            .overlay(HStack {
                Image(systemName: imageName).foregroundColor(.green)
                
                Text(text)
                
            })
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
                InfoView(text: "new number", imageName: "phone.fill").previewLayout(.sizeThatFits)
    }
}

//
//  FormButton.swift
//  Dought
//
//  Created by Lee Watkins on 15/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct FormButton: View {
    let image: Image
    let text: String
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: onTap) {
                HStack {
                    image
                    Text(text)
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct FormButton_Previews: PreviewProvider {
    static var previews: some View {
        FormButton(image: Image(systemName: "plus.circle.fill"), text: "Add step"){}
    }
}

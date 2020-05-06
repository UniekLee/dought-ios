//
//  FormSaveButton.swift
//  Dought
//
//  Created by Lee Watkins on 06/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct FormSaveButton: View {
    private var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                HStack {
                    Image(systemName: "square.and.arrow.down")
                    Text("Save")
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct FormSaveButton_Previews: PreviewProvider {
    static var previews: some View {
        FormSaveButton(action: {})
    }
}

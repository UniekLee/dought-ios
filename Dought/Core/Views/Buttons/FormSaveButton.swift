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
        FormButton(image: Image(systemName: "square.and.arrow.down"),
                   text: "Save",
                   onTap: action)
    }
}

struct FormSaveButton_Previews: PreviewProvider {
    static var previews: some View {
        FormSaveButton(action: {})
    }
}

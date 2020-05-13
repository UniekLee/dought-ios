//
//  CancelButton.swift
//  Dought
//
//  Created by Lee Watkins on 13/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct CancelButton: View {
    @Binding var screenPresentation: PresentationMode
    
    var body: some View {
        Button(action: {
            self.screenPresentation.dismiss()
        }, label: {
            Text("Cancel")
        })
    }
}

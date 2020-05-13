//
//  CancelButton.swift
//  Dought
//
//  Created by Lee Watkins on 13/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct CancelButton<T>: View {
    var onCommit: (T?) -> Void
    
    var body: some View {
        Button(action: {
            self.onCommit(.none)
        }, label: {
            Text("Cancel")
        })
    }
}

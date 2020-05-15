//
//  LabeledTextField.swift
//  Dought
//
//  Created by Lee Watkins on 30/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct LabeledTextField: View {
    var label: String
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label).font(.subheadline).foregroundColor(text.isEmpty ? .primary : .secondary)
            TextField(placeHolder, text: $text)
        }
    }
}

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        WrapperView()
    }
}

fileprivate struct WrapperView: View {
    @State private var text: String = ""
    
    var body: some View {
        LabeledTextField(label: "Name", placeHolder: "Bulk fermentation", text: $text)
    }
}

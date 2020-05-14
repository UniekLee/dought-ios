//
//  RightDetailCell.swift
//  Dought
//
//  Created by Lee Watkins on 14/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct RightDetailCell: View {
    let text: String
    let detail: String
    let onTap: (() -> Void)?
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Text(detail)
        }.background(background)
    }
    
    private var background: some View {
        if let onTapAction = onTap {
            return AnyView(Button(action: onTapAction, label: { EmptyView() }))
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct RightDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        RightDetailCell(text: "Text left", detail: "Detail right", onTap: .none)
    }
}

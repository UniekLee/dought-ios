//
//  NoActiveBakeCard.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct NoActiveBakeCard: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image("dough-ball")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(maxWidth: 120)
                    .foregroundColor(.accentColor)
                    .padding()
                Text("No active bake")
                    .font(.headline)
                Text("Choose a schedule that works for you and get that first bake underway!")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                HStack(spacing: 0) {
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                        .frame(width: 44, height: 44)
                    Text("Start a bake")
                }
                .foregroundColor(.accentColor)
            }
            .padding()
            Spacer()
        }
        .padding()
        .background(Color("cardBackground"))
        .cornerRadius(16)
        .shadow(radius: 7)
    }
}


struct NoActiveBakeCard_Previews: PreviewProvider {
    static var previews: some View {
        NoActiveBakeCard()
    }
}

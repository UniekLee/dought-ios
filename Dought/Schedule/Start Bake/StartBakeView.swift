//
//  StartBakeView.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct StartBakeView<Presenting>: View where Presenting: View {
    @Binding var isShowing: Bool
    let presenting: Presenting
    let onCommit: (Date) -> Void
    
    @State private var selectedDate: Date = .tomorrow
    
    
    var body: some View {
//        GeometryReader { geometry in
            ZStack {
                self.presenting
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 20 : 0)
                
                VStack {
                    Text("Choose start date")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    DatePicker(selection: self.$selectedDate,
                               in: PartialRangeFrom(Date.tomorrow),
                               displayedComponents: .date) {
                        EmptyView()
                    }
                    .labelsHidden()
                    
                    Button(action: { self.onCommit(self.selectedDate) }) {
                        Spacer()
                        Text("Start").fontWeight(.bold)
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(10)
                }
                .padding()
                .background(Color("cardBackground"))
                .cornerRadius(25)
                .shadow(radius: 7)
                .padding()
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)
            }
//        }
    }
}

extension View {
    func startBakeView(isShowing: Binding<Bool>,
                       onCommit: @escaping (Date) -> Void) -> some View {
        StartBakeView(isShowing: isShowing,
                      presenting: self,
                      onCommit: onCommit)
    }
}

struct StartBakeView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView().startBakeView(isShowing: .constant(true)) { _ in
            // No-op
        }
    }
}

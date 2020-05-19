//
//  TimetableTemplateView.swift
//  Dought
//
//  Created by Lee Watkins on 19/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

extension HorizontalAlignment {
    private enum DateTimeColumnAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.trailing]
        }
    }
    static let dateTimeColumnAlignment = HorizontalAlignment(DateTimeColumnAlignment.self)
}

extension View {
    func printing<V>(_ value: V) -> Self {
        print(value)
        return self
    }
}

struct TimetableTemplateView: View {
    var body: some View {
        List {
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: 10)
                VStack(alignment: .dateTimeColumnAlignment, spacing: 10) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Fri").font(.subheadline)
                            .alignmentGuide(.dateTimeColumnAlignment) { $0[.trailing] }
                        Text("Levain build")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "plus.square.fill")
                                .resizable()
                                .padding(5)
                        }
                        .foregroundColor(.red)
                        .frame(width: 44, height: 44, alignment: .trailing)
                    }
                    
                    HStack {
                        Text("09:00").font(.subheadline)
                            .alignmentGuide(.dateTimeColumnAlignment) { $0[.trailing] }
                        Text("Add levain")
                            .font(.body)
                        Spacer()
                    }
                    HStack {
                        Text("11:00").font(.subheadline)
                            .alignmentGuide(.dateTimeColumnAlignment) { $0[.trailing] }
                        Text("Autolyse")
                            .font(.body)
                        Spacer()
                    }
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(3)
            .shadow(radius: 7)
            //                .frame(width: 360)
        }
        .navigationBarTitle("Weekend bake")
    }
}

struct TimetableTemplateView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView {
            TimetableTemplateView()
//        }
    }
}

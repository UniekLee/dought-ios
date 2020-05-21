//
//  BakesListView.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct BakesListView: View {
    @State private var isShowingActiveBake: Bool = false
    @State private var isShowingScheduleModal: Bool = false
    @State private var activeBake: Bake = .devMock()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                NavigationLink(destination: ActiveBakeView(bake: activeBake),
                               isActive: $isShowingActiveBake) { EmptyView() }
                Text("DOUGHT")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.accentColor)
                    .padding()
                
                HStack {
                    Text("Active bake")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                NoActiveBakeCard().onTapGesture {
                    self.isShowingScheduleModal.toggle()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Previous bakes")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Coming in future")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                //.hidden()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text("Home"), displayMode: .inline)
            .sheet(isPresented: $isShowingScheduleModal) {
                SchedulesListView() { bake in
                    // TODO: What do we do with the bake?
                    self.activeBake = bake
                    self.isShowingActiveBake.toggle()
                    self.isShowingScheduleModal.toggle()
                }
                    .modifier(AppDefaults())
            }
        }
    }
}

struct BakesView_Previews: PreviewProvider {
    static var previews: some View {
        BakesListView()
    }
}

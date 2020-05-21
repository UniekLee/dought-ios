//
//  BakesListView.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct BakesListView: View {
    @State private var activeBake: Bake? = nil
    @State private var isChoosingSchedule: Bool = false
    
    private var isShowingScheduleModal: Bool {
        return activeBake == nil && isChoosingSchedule
    }
    
    var body: some View {
        NavigationView {
//            NavigationLink(destination: ActiveBakeView(bake: activeBake), tag: <#T##Hashable#>, selection: <#T##Binding<Hashable?>#>, label: <#T##() -> _#>)
            VStack(spacing: 16) {
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
                    self.isChoosingSchedule.toggle()
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
            .navigationBarTitle("Dought")
            .navigationBarHidden(true)
            .sheet(isPresented:
                Binding(get: {
                    self.isShowingScheduleModal
                }, set: {
                    self.isChoosingSchedule = $0
                })
            ) {
                SchedulesListView(newBake: self.$activeBake)
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

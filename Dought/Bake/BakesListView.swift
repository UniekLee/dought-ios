//
//  BakesListView.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct BakesListView: View {
    @State var activeBake: Bake? = nil
    @State var isShowingScheduleList: Bool = false
    
    var body: some View {
        NavigationView {
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
                    self.isShowingScheduleList.toggle()
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
            .sheet(isPresented: $isShowingScheduleList) {
                SchedulesListView()
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

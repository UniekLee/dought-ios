//
//  BakesListView.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct BakesListView: View {
    @State var activeBake: BakeV2? = nil
    @State var isShowingScheduleList: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Text("Dought")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding()
                
                HStack {
                    Text("Active bake")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    VStack {
                        Image("dough-ball")
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(maxWidth: 120)
                            .foregroundColor(.secondary)
                            .padding()
                        Text("No active bakes")
                            .font(.headline)
                        Text("Choose a schedule that works for you and get that first bake underway!")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                        Button(action: { self.isShowingScheduleList.toggle() }) {
                            HStack(spacing: 0) {
                                Image(systemName: "plus.square.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(10)
                                    .frame(width: 44, height: 44)
                                Text("Start a bake")
                            }
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

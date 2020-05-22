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
    @State private var activeBake: Bake?
    
    private var activeBakeView: some View {
        if let bake = activeBake {
            return ActiveBakeView(bake: bake) {
                self.activeBake = nil
                self.isShowingActiveBake.toggle()
            }.eraseToAnyView()
        } else {
            return EmptyView().eraseToAnyView()
        }
    }
    
    private var activeBakeCard: some View {
        if let bake = activeBake {
            return ActiveBakeCard(
                activeBake: Binding(get: { bake },
                                    set: { self.activeBake = $0 })
            )
                .onTapGesture {
                    self.isShowingActiveBake.toggle()
            }
            .eraseToAnyView()
        } else {
            return NoActiveBakeCard()
                .onTapGesture {
                    self.isShowingScheduleModal.toggle()
            }
            .eraseToAnyView()
        }
    }
    
    private var hasActiveBake: Bool {
        return activeBake != nil
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                NavigationLink(destination: activeBakeView,
                               isActive: $isShowingActiveBake) { EmptyView() }
                
                HStack {
                    Text("Active bake")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                activeBakeCard
                
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
            .navigationBarTitle(
                Text("Home")
                    .fontWeight(.black)
                    .foregroundColor(.accentColor),
                displayMode: .inline
            )
            .sheet(isPresented: $isShowingScheduleModal) {
                SchedulesListView(isShowing: self.$isShowingScheduleModal) { bake in
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

struct ActiveBakeCard: View {
    @Binding var activeBake: Bake
    
    private var activeBakeHeadline: String {
        return activeBake.schedule.name
    }
    
    private var activeBakeSubheadline: String {
        return "\(activeBake.start.formatter.weekdayName); \(activeBake.start.formatter.dateTime)"
    }
    
    var body: some View {
        HStack {
            Image("dough-ball")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
                .frame(maxWidth: 60)
                .foregroundColor(.accentColor)
                .padding()
            VStack(alignment: .leading) {
                Text(activeBakeHeadline)
                    .font(.headline)
                Text(activeBakeSubheadline)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color("cardBackground"))
        .cornerRadius(16)
        .shadow(radius: 7)
    }
}

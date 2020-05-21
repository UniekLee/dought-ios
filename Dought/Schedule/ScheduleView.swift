//
//  ScheduleView.swift
//  Dought
//
//  Created by Lee Watkins on 19/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    let schedule: Schedule
    
    @State var activeBake: Schedule? = .none
    @Binding var isStartBakeShowing: Bool
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    ForEach(schedule.stages) { stage in
                        // Could this take a VM rather?
                        // If the ScheduleView has a VM, that could calculate the day of each stage
                        // and feed that into the ScheduleStageCard_VM
                        ScheduleStageCard(stage: stage,
                                          day: self.schedule.day(of: stage))
//                                                .contextMenu {
//                                                    VStack {
//                                                        // TODO: Something cool :sunglasses:
//                                                        Button(action: {}) {
//                                                            HStack {
//                                                                Text("Delete")
//                                                                Image(systemName: "trash")
//                                                            }
//                                                        }
//                                                    }
//                                            }
                    }
                }
            }
            .navigationBarTitle(schedule.name)
            .navigationBarItems(trailing: Button("Start bake") {
                withAnimation {
                    self.isStartBakeShowing.toggle()
                }
            })
    }
}

struct TimetableTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(schedule: .devMock(),
                     isStartBakeShowing: .constant(false))
    }
}

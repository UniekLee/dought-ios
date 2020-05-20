//
//  ScheduleView.swift
//  Dought
//
//  Created by Lee Watkins on 19/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    let schedule: Schedule = .devMock()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                ForEach(schedule.stages) { stage in
                    // Could this take a VM rather?
                    // If the ScheduleView has a VM, that could calculate the day of each stage
                    // and feed that into the ScheduleStageCard_VM
                    ScheduleStageCard(stage: stage,
                                      day: self.schedule.day(of: stage))
//                        .contextMenu {
//                            VStack {
//                                // TODO: Something cool :sunglasses:
//                                Button(action: {}) {
//                                    HStack {
//                                        Text("Delete")
//                                        Image(systemName: "trash")
//                                    }
//                                }
//                            }
//                    }
                }
            }
        }
        .navigationBarTitle(schedule.name)
    }
}

struct TimetableTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

struct TimetableTemplateView_NavStacked_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScheduleView()
        }
    }
}

struct TimetableTemplateView_DarkMode_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView().environment(\.colorScheme, .dark)
    }
}

struct TimetableTemplateView_LargeText_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView().environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}

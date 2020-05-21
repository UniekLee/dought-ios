//
//  SchedulesListView.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct SchedulesListView: View {
    @State private var isStartBakeShowing: Bool = false
    @State private var selectedSchedule: Schedule? = nil
    @Binding var newBake: Bake?
    
    @State private var schedules: [Schedule] = Schedule.devMockList()
    
    var body: some View {
        NavigationView {
            List(schedules) { schedule in
                NavigationLink(destination: ScheduleView(schedule: schedule,
                                                         isStartBakeShowing: self.$isStartBakeShowing),
                               tag: schedule,
                               selection: self.$selectedSchedule) {
                                VStack(alignment: .leading) {
                                    Text(schedule.name)
                                    Text(schedule.details)
                                        .font(.footnote)
                                        .lineLimit(nil)
                                        .foregroundColor(.secondary)
                                }
                }
                
            }
            .navigationBarTitle("Choose a schedule")
            
            
        }
        .startBakeView(isShowing: $isStartBakeShowing) { date in
            guard let schedule = self.selectedSchedule else {
                fatalError("How did we select a schedule with none selected?")
            }
            self.newBake = Bake(schedule: schedule, start: date)
            withAnimation {
                self.isStartBakeShowing.toggle()
            }
        }
    }
}

struct SchedulesList_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesListView(newBake: .constant(nil))
    }
}

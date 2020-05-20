//
//  SchedulesListView.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct SchedulesListView: View {
    @State var isStartBakeShowing: Bool = false
    
    var body: some View {
        NavigationView {
            List(Schedule.devMockList()) { schedule in
                NavigationLink(destination: ScheduleView(schedule: schedule, isStartBakeShowing: self.$isStartBakeShowing)) {
                    Text(schedule.name)
                }
            }
            .navigationBarTitle("Schedules")
        }
//        .blur(radius: isStartBakeShowing ? 20 : 0)
        .startBakeView(isShowing: $isStartBakeShowing) {
            withAnimation {
                self.isStartBakeShowing.toggle()
            }
        }
    }
}

struct SchedulesList_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesListView()
    }
}

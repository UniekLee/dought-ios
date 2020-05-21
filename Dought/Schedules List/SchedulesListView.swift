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

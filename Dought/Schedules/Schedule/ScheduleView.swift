//
//  ScheduleView.swift
//  Dought
//
//  Created by Lee Watkins on 19/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

extension AppState {
    struct ScheduleState: Equatable {
        var schedule: Schedule
        var isChooseBakeStartDateShowing: Bool
    }
}

extension AppAction {
    enum ScheduleAction {
        case chooseBakeStartDate(isShown: Bool)
    }
}

let scheduleReducer: Reducer<AppState.ScheduleState, AppAction.ScheduleAction, Void> = Reducer { state, action, _ in
    switch action {
    case .chooseBakeStartDate(let isShown):
        state.isChooseBakeStartDateShowing = isShown
        return .none
    }
}

struct ScheduleView: View {
    let store: Store<AppState.ScheduleState, AppAction.ScheduleAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    ForEach(viewStore.schedule.stages) { stage in
                        // Could this take a VM rather?
                        // If the ScheduleView has a VM, that could calculate the day of each stage
                        // and feed that into the ScheduleStageCard_VM
                        ScheduleStageCard(stage: stage,
                                          day: viewStore.schedule.day(of: stage))
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
            .navigationBarTitle(viewStore.schedule.name)
            .navigationBarItems(trailing: Button("Start bake") {
                withAnimation {
                    viewStore.send(.chooseBakeStartDate(isShown: true))
                }
            })
        }
    }
}

struct TimetableTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(
            store: Store(
                initialState: AppState.ScheduleState(schedule: .devMock(),
                                                     isChooseBakeStartDateShowing: false),
                reducer: scheduleReducer,
                environment: ())
        )
    }
}

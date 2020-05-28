//
//  SchedulesListView.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

extension AppState {
    struct SchedulesListState: Equatable {
        var isChooseBakeStartDateShowing: Bool = false

        var schedules: IdentifiedArrayOf<Schedule> = []
        var selection: Identified<Schedule.ID, AppState.ScheduleState?>?
        
        var isShowing: Bool
    }
}

extension AppAction {
    enum SchedulesListAction {
        case navigateToSchedule(id: UUID)
        case chooseStartDate(isShown: Bool)
        case startBake(schedule: Schedule, date: Date)
        case schedule(AppAction.ScheduleAction)
        case cancel
    }
}

let schedulesListReducer: Reducer<AppState.SchedulesListState, AppAction.SchedulesListAction, Void> = .combine(
    scheduleReducer.optional.pullback(
        state: \AppState.SchedulesListState.selection?.value as! WritableKeyPath<AppState.SchedulesListState, AppState.ScheduleState?>,
        action: /AppAction.SchedulesListAction.schedule,
        environment: ({ _ in })
    ),
    Reducer { state, action, _ in
        switch action {
        case .navigateToSchedule(let id):
            if let selectedSchedule = state.schedules[id: id] {
                state.selection = Identified(
                    AppState.ScheduleState(
                        schedule: selectedSchedule,
                        isChooseBakeStartDateShowing: false
                    ),
                    id: id
                )
            }
            return .none
        case .chooseStartDate(let isShown):
            state.isChooseBakeStartDateShowing = isShown
            return .none
        case .startBake(schedule: let schedule, date: let date):
            // TODO: This is wrong - this particular action needs to be bubbled up...how do we do this?
            state.selection = schedule
            return .none
        case .cancel:
            state.isShowing = false
            return .none
        case .schedule(let scheduleAction):
            if case .chooseBakeStartDate(let isShown) = scheduleAction {
                state.isChooseBakeStartDateShowing = isShown
            }
            return .none
        }
        )
}

struct SchedulesListView: View {
    let store: Store<AppState.SchedulesListState, AppAction.SchedulesListAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List(viewStore.schedules) { schedule in
//                    NavigationLink(
//                        destination: ScheduleView(
//                            schedule: schedule,
//                            isStartBakeShowing: viewStore.binding(
//                                get: { $0.isStartBakeShowing },
//                                send: AppAction.SchedulesListAction.chooseStartDate
//                            )
//                        ),
//                        tag: schedule,
//                        selection: viewStore.binding(
//                            get: { $0.selectedSchedule },
//                            set: { viewStore.send(.selectSchedule($0)) }
//                        )
//                    ) {
                        VStack(alignment: .leading) {
                            Text(schedule.name)
                            Text(schedule.details)
                                .font(.footnote)
                                .lineLimit(nil)
                                .foregroundColor(.secondary)
//                        }
                    }

                }
                .navigationBarTitle("Choose a schedule")
                .navigationBarItems(leading: Button("Cancel") {
                    viewStore.send(AppAction.SchedulesListAction.cancel)
                })
            }
            .chooseDayAlert(isShowing:
                viewStore.binding(
                    get: { $0.isChooseBakeStartDateShowing },
                    send: AppAction.SchedulesListAction.chooseStartDate
                )
            ) { date in
                guard let scheduleState = viewStore.selection?.value else {
                    fatalError("How did we select a schedule with none selected?")
                }

                let newBake = Bake(schedule: scheduleState.schedule, start: date)
                withAnimation {
                    viewStore.send(.chooseStartDate(isShown: false))
                }

//                self.onCommit(newBake)
            }
        }
    }
}

struct SchedulesList_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesListView(
            store: Store(
                initialState: AppState.SchedulesListState(isShowing: true),
                reducer: schedulesListReducer,
                environment: ()
            )
        )
    }
}

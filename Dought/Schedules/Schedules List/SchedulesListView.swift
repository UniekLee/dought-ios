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
        // Injected state
        var schedules: [Schedule]
        /// Used for pullback to BakesListView when cancelling from within the view
        /// (ie: when cancel button is tapped)
        var isPresenting: Bool

        // Internal state
        var selection: AppState.ScheduleState? = nil
        var isShowingChooseBakeStartDate: Bool = false
    }
}

extension AppAction {
    enum SchedulesListAction {
        case navigateToSchedule(schedule: Schedule?)
        case chooseStartDate(isShown: Bool)
        case startBake(schedule: Schedule, date: Date)
        case schedule(AppAction.ScheduleAction)
        case dismissSelf
    }
}

let schedulesListReducer = Reducer<AppState.SchedulesListState, AppAction.SchedulesListAction, Void>
    .combine(
        Reducer { state, action, _ in
            switch action {
            case .navigateToSchedule(let schedule):
                if let schedule = schedule {
                    let scheduleState = AppState.ScheduleState(
                        schedule: schedule,
                        isShowingChooseBakeStartDate: false
                    )
                    state.selection = scheduleState
                } else {
                    state.selection = nil
                }
                return .none
            case .chooseStartDate(let isShown):
                state.isShowingChooseBakeStartDate = isShown
                return .none
            case .startBake(schedule: let schedule, date: let date):
                // TODO: This is wrong - this particular action needs to be bubbled up...how do we do this?
                let scheduleState = AppState.ScheduleState(
                    schedule: schedule,
                    isShowingChooseBakeStartDate: false
                )
                state.selection = scheduleState
                return .none
            case .dismissSelf:
                state.isPresenting = false
                return .none
            case .schedule(let scheduleAction):
                if case .chooseBakeStartDate(let isShown) = scheduleAction {
                    state.isShowingChooseBakeStartDate = isShown
                }
                return .none
            }
        },
        scheduleReducer.optional.pullback(
            state: \AppState.SchedulesListState.selection,
            action: /AppAction.SchedulesListAction.schedule,
            environment: ({ _ in })
        )
)

struct SchedulesListView: View {
    let store: Store<AppState.SchedulesListState, AppAction.SchedulesListAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List(viewStore.schedules) { schedule in
                    NavigationLink(
                        destination:
                        IfLetStore(
                            self.store.scope(
                                state: \.selection,
                                action: AppAction.SchedulesListAction.schedule
                            ),
                            then: ScheduleView.init(store:)
                        ),
                        tag: schedule,
                        selection: viewStore.binding(
                            get: \.selection?.schedule,
                            send: AppAction.SchedulesListAction.navigateToSchedule(schedule:)
                        )
                    ) {
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
                .navigationBarItems(leading: Button("Cancel") {
                    viewStore.send(AppAction.SchedulesListAction.dismissSelf)
                })
            }
            .chooseDayAlert(isShowing:
                viewStore.binding(
                    get: \.isShowingChooseBakeStartDate,
                    send: AppAction.SchedulesListAction.chooseStartDate
                )
            ) { date in
                guard let scheduleState = viewStore.selection else {
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
                initialState: AppState.SchedulesListState(
                    schedules: Schedule.devMockList(),
                    isPresenting: true
                ),
                reducer: schedulesListReducer,
                environment: ()
            )
        )
    }
}

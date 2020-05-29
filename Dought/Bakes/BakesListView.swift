//
//  BakesListView.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

extension AppState {
    struct BakesListState: Equatable {
        var activeBake: ActiveBakeState?
        var schedulesList: SchedulesListState?
        var isShowingActiveBake: Bool = false
        var isShowingScheduleModal: Bool = false
        var isCancellingActiveBake: Bool = false
    }
}

extension AppAction {    
    enum BakesListAction {
        case startBake(schedule: Schedule, startDate: Date)
        case setActiveBake(isShown: Bool)
        case chooseSchedule(isShown: Bool)
        case activeBake(ActiveBakeAction)
        case schedulesList(AppAction.SchedulesListAction)
        case bakeCancelled
    }
}

let bakesListReducer = Reducer<AppState.BakesListState, AppAction.BakesListAction, Void>
    .combine(
        Reducer { state, action, _ in
            switch action {
            case .startBake(let schedule, let startDate):
                _ = Bake(schedule: schedule, start: startDate)
                state.activeBake = AppState.ActiveBakeState()
                return .none
            case .setActiveBake(let isShown):
                state.isShowingActiveBake = isShown
                return .none
            case .chooseSchedule(let isShown):
                state.isShowingScheduleModal = isShown
                return .none
            case .schedulesList(let action):
                if case .dismissSelf = action {
                    state.isShowingScheduleModal = false
                }
                return .none
            case .bakeCancelled:
                state.activeBake = nil
                return .none
            }
        },
        schedulesListReducer.optional.pullback(
            state: \AppState.BakesListState.schedulesList,
            action: /AppAction.BakesListAction.schedulesList,
            environment: ({ _ in })
        )
)

struct BakesListView: View {
    let store: Store<AppState.BakesListState, AppAction.BakesListAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                VStack(spacing: 16) {
                    NavigationLink(
                        destination: IfLetStore(
                            self.store.scope(state: \.activeBake,
                                             action: AppAction.BakesListAction.activeBake),
                            then: ActiveBakeView.init(store:)
                        ),
                        isActive: viewStore.binding(
                            get: \.isShowingActiveBake,
                            send: AppAction.BakesListAction.setActiveBake(isShown:)
                        )
                    ) { EmptyView() }
                    
                    HStack {
                        Text("Active bake")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
//                    IfLetStore(
//                        self.store.scope(state: \.activeBake,
//                                         action: AppAction.BakesListAction.activeBake),
//                        then: ActiveBakeView.init(store:),
//                        else: EmptyView()
//                    )
//
//                    activeBakeCard
                    NoActiveBakeCard()
                        .onTapGesture {
                            viewStore.send(AppAction.BakesListAction.chooseSchedule(isShown: true))
                    }
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
                .navigationBarTitle(
                    Text("Home")
                        .fontWeight(.black)
                        .foregroundColor(.accentColor),
                    displayMode: .inline
                )
                .sheet(
                    isPresented: viewStore.binding(
                        get: \.isShowingScheduleModal,
                        send: AppAction.BakesListAction.chooseSchedule
                    )
                ) {
                    SchedulesListView(
                        store: Store(
                            initialState: AppState.SchedulesListState(
                                schedules: Schedule.devMockList(),
                                isPresenting: viewStore.state.isShowingScheduleModal
                            ),
                            reducer: schedulesListReducer,
                            environment: ()
                        )
                    )
                    .modifier(AppDefaults())
                }
            }
        }
    }
    
//    private var activeBakeCard: some View {
//        if let bake = activeBake {
//            return ActiveBakeCard(
//                activeBake: Binding(get: { bake },
//                                    set: { self.activeBake = $0 })
//            )
//                .onTapGesture {
//                    self.isShowingActiveBake.toggle()
//            }
//            .contextMenu(menuItems: {
//                Button(action: {
//                    self.isCancellingActiveBake.toggle()
//                }) {
//                    HStack {
//                        Text("Cancel bake")
//                        Image(systemName: "nosign")
//                    }
//                }
//            })
//            .alert(isPresented: $isCancellingActiveBake) {
//                Alert(
//                    title: Text("Cancel this bake?"),
//                    message: Text("Are you sure that you want to cancel this bake?"),
//                    primaryButton: .destructive(Text("Cancel bake")) { self.cancelActiveBake() },
//                    secondaryButton: .cancel(Text("Continue bake"))
//                )
//            }
//            .eraseToAnyView()
//        } else {
//            return NoActiveBakeCard()
//                .onTapGesture {
//                    self.isShowingScheduleModal.toggle()
//            }
//            .eraseToAnyView()
//        }
//    }
//
//    private func cancelActiveBake() {
//        withAnimation {
//            activeBake = nil
//            isShowingActiveBake = false
//        }
//    }
}

struct BakesView_Previews: PreviewProvider {
    static var previews: some View {
        BakesListView(
            store: Store(
                initialState: AppState.BakesListState(),
                reducer: bakesListReducer,
                environment: ()
            )
        )
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

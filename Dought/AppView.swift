//
//  AppView.swift
//  Dought
//
//  Created by Lee Watkins on 26/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            IfLetStore(
                self.store.scope(state: { $0.bakesList }, action: AppAction.bakesList),
                then: BakesListView.init(store:)
            )           
        }
    }
}

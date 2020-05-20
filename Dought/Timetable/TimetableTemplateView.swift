//
//  TimetableTemplateView.swift
//  Dought
//
//  Created by Lee Watkins on 19/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct TimetableTemplateView: View {
    let stages: [BakeStage] = BakeStage.devData()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                ForEach(stages) { stage in
                    BakeStageCard(stage: stage)
                }
            }
        }
        .navigationBarTitle("Weekend bake")
    }
}

struct TimetableTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableTemplateView()
    }
}

struct TimetableTemplateView_NavStacked_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimetableTemplateView()
        }
    }
}

struct TimetableTemplateView_DarkMode_Previews: PreviewProvider {
    static var previews: some View {
        TimetableTemplateView().environment(\.colorScheme, .dark)
    }
}

struct TimetableTemplateView_LargeText_Previews: PreviewProvider {
    static var previews: some View {
        TimetableTemplateView().environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}

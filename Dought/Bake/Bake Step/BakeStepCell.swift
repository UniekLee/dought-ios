//
//  BakeStepCell.swift
//  Dought
//
//  Created by Lee Watkins on 29/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI
import Combine

class BakeStepCellViewModel: ObservableObject, Identifiable {
    @Environment(\.calendar) private var calendar: Calendar
    @Published private(set) var step: BakeStep
    @Published private(set) var start: Date

    var id: UUID = UUID()
    @Published var name: String = ""
    @Published var startDelay: String = ""
    @Published var startTime: String = ""
    
    @Published var isThisAnAwkwardTime: Bool = false

    private var cancellables = Set<AnyCancellable>()
    
    init(step: BakeStep, startDate: Date) {
        self.step = step
        self.start = startDate
        
        $step.map { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $step.map(\.name)
            .assign(to: \.name, on: self)
            .store(in: &cancellables)
        
        $step.map(\.startDelay)
            .compactMap({ try? TimeCalculator.formatted(duration: $0) })
            .assign(to: \.startDelay, on: self)
            .store(in: &cancellables)
        
        $start.map({ TimeCalculator.formatted(startTime: $0) })
            .assign(to: \.startTime, on: self)
            .store(in: &cancellables)
        
        $start.map({ self.isThisAnAwkward(time: $0) })
            .assign(to: \.isThisAnAwkwardTime, on: self)
            .store(in: &cancellables)
    }
    
    private func isThisAnAwkward(time: Date) -> Bool {
        guard let hour = calendar.dateComponents([.hour], from: time).hour else {
            return false
        }
        // TODO: Get these values from settings...ie: the Environment
        return 21 < hour || hour < 9
    }
}

struct BakeStepCell: View {
    @ObservedObject var viewModel: BakeStepCellViewModel
    var onEdit: (() -> Void)?
    
    var body: some View {
        HStack {
            Text(viewModel.name)
            Spacer()
            VStack(alignment: .trailing) {
                Text("+ " + viewModel.startDelay).foregroundColor(.secondary)
                Text(viewModel.startTime)
            }
        }
        .padding([.top, .bottom], 10)
        .background(
            Group {
                if onEdit != nil {
                    Button(action: onEdit!) { EmptyView() }
                }
            }
        )
        .listRowBackground(
            Group {
                if viewModel.isThisAnAwkwardTime {
                    Color.red.opacity(0.2)
                }
            }
        )
    }
}

//struct BakeStepCell_Previews: PreviewProvider {
//    static var previews: some View {
//        return BakeStepCell(step: BakeStep(name: "Levain build", duration: 75),
//                            start: Date(),
//                            onEdit: {})
//    }
//}

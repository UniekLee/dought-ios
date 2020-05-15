//
//  BakeView.swift
//  Dought
//
//  Created by Lee Watkins on 29/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

enum BakeTimeType {
    case start
    case end
}

struct BakeView: View {
    enum Modal: Identifiable {
        case modify(step: BakeStep)
        case time(label: String, currentTime: Date, type: BakeTimeType)
        case duration(label: String, current: Minutes)
        
        var id: String {
            switch self {
            case .modify(let step): return "step." + step.id.uuidString
            case .time(let label, _, _): return "time." + label
            case .duration(let label, _): return "duration." + label
            }
        }
    }
    
    @ObservedObject var bakeVM: BakeViewModel

    // State
    @State private var modal: Modal? = .none
    
    var body: some View {
        List {
            // MARK: - Start of bake
            RightDetailCell(text: "Step",
                            detail: "Start time",
                            onTap: .none)
                .listRowBackground(Color.gray.opacity(0.2))
            RightDetailCell(text: "Begin",
                            detail: bakeVM.startTime) {
                                // TODO: Start time view model
                                self.modal = .time(label: "Bake start time",
                                                   currentTime: self.bakeVM.bakeRepository.bake.startTime,
                                                   type: .start)
            }
            
            // MARK: - List steps
            ForEach(bakeVM.bakeStepCellViewModels) { viewModel in
                BakeStepCell(viewModel: viewModel) {
                    self.modal = .modify(step: viewModel.step)
                }
            }
            .onDelete(perform: bakeVM.removeSteps)
            .onMove(perform: bakeVM.moveStep)
            
            // MARK: - Add step
            FormButton(image: Image(systemName: "plus.circle.fill"),
                       text: "Add step") {
                self.modal = .modify(step: .makeNew())
            }
            .foregroundColor(.accentColor)
            
            // MARK: - End of bake
            RightDetailCell(text: "Last step duration",
                            detail: "+ " + bakeVM.lastStepDuration) {
                                // TODO: Final step duration VM
                                self.modal = .duration(label: "Last step duration",
                                                       current: self.bakeVM.bakeRepository.bake.finalStepDuration)
            }
            RightDetailCell(text: "Eat & enjoy",
                            detail: bakeVM.endTime) {
                                self.modal = .time(label: "Bake end time",
                                                   currentTime: self.bakeVM.endTimeDate,
                                                   type: .end)
            }
        }
        .navigationBarTitle("Bake")
        .navigationBarItems(trailing: EditButton())
        .sheet(item: $modal,
               onDismiss: {}) { modal in
                return self.view(for: modal)
        }
    }
    
    private func view(for modal: Modal?) -> AnyView {
        switch modal {
        case .modify(let step):
            return AnyView (
                ModifyBakeStepView(step: step) { newStep in
                    self.bakeVM.addOrUpdate(step: newStep)
                    self.modal = .none
                }
                .modifier(AppDefaults())
            )
        case .time(let label, let time, let type):
            return AnyView(
                SetTimeView(label: label, time: time) { newTime in
                    self.updateTime(type: type, to: newTime)
                    self.modal = .none
                }
                .modifier(AppDefaults())
            )
        case .duration(let label, let duration):
            return AnyView(
                DurationPicker(title: label,
                               currentDuration: duration) { newDuration in
                                self.bakeVM.updateLastStepDuration(newDuration)
                                self.modal = .none
                }
                .modifier(AppDefaults())
            )
        case .none:
            return AnyView(EmptyView())
        }
    }
    
    private func updateTime(type: BakeTimeType, to newTime: Date) {
        switch type {
        case .start:
            bakeVM.updateStartTime(newTime)
        case .end:
            bakeVM.updateEndTime(newTime)
        }
    }
}

struct BakeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           WrapperView()
              .environment(\.colorScheme, .light)

           WrapperView()
              .environment(\.colorScheme, .dark)
        }
    }
}

fileprivate struct WrapperView: View {
    @State private var bakeVM: BakeViewModel = BakeViewModel(bakeRepository: DevBakeRepository())
    
    var body: some View {
        BakeView(bakeVM: bakeVM)
    }
}

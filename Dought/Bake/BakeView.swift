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
    
    // Bindings
    @ObservedObject var bakeVM: BakeViewModel

    // State
    @State private var modal: Modal? = .none
    
    var body: some View {
        List {
            HStack {
                Text("Step")
                Spacer()
                Text("Start time")
                
            }
            .listRowBackground(Color.gray.opacity(0.2))
            HStack {
                Text("Begin")
                Spacer()
                Text(bakeVM.startTime)
            }
            .background(
                // TODO: Start time view model
                Button(action: {
                    self.modal = .time(label: "Bake start time",
                                       currentTime: self.bakeVM.bakeRepository.bake.startTime,
                                       type: .start)
                }) { EmptyView() }
            )
            ForEach(bakeVM.bakeStepCellViewModels) { step in
                BakeStepCell(step: step,
                             start: self.startTime(of: step)) {
                                self.modal = .modify(step: step)
                }.listRowBackground(
                    Group {
                        if self.isThisAnAwkward(time: self.startTime(of: step)) {
                            Color.red.opacity(0.2)
                        }
                    }
                )
            }
            .onDelete(perform: bakeVM.removeSteps)
            .onMove(perform: bakeVM.moveStep)
            HStack {
                Spacer()
                Button(action: {
                    self.modal = .modify(step: .makeNew())
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Add step")
                    }
                }
                .padding()
                .foregroundColor(.accentColor)
                Spacer()
            }
            HStack {
                Text("Last step duration")
                Spacer()
                Text("+ " + bakeVM.lastStepDuration)
            }
            .background(
                Button(action: {
                    // TODO: Final step duration VM
                    self.modal = .duration(label: "Last step duration",
                                           current: self.bakeVM.bakeRepository.bake.finalStepDuration)
                }) { EmptyView() }
            )
            HStack {
                Text("Eat & enjoy")
                Spacer()
                Text(bakeVM.endTime)
            }
            .background(
                Button(action: {
                    // TODO: End time VM
                    self.modal = .time(label: "Bake end time",
                                       currentTime: self.bakeVM.bakeRepository.bake.endTime,
                                       type: .end)
                }) { EmptyView() }
            )
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
    
    // TODO: Implement BakeStepVM
    private func startTime(of step: BakeStep) -> Date {
        guard let index = bakeVM.bakeRepository.bake.steps.firstIndex(where: { $0.id == step.id }) else { return Date() }
        
        return TimeCalculator.add(bakeVM.bakeRepository.bake.steps[0...index].map({ $0.duration }),
                                  to: bakeVM.bakeRepository.bake.startTime)
    }
    
    private func isThisAnAwkward(time: Date) -> Bool {
        guard let hour = Calendar.current.dateComponents([.hour], from: time).hour else {
            return false
        }
        return 21 < hour || hour < 9
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

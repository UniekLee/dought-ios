//
//  BakeView.swift
//  Dought
//
//  Created by Lee Watkins on 29/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct Bake {
    var steps: [BakeStep]
    var startTime: Date = Date(timeIntervalSince1970: TimeInterval(1588669200))
    
    var finalStepDuration: Minutes = 120
    
    var endTime: Date {
        let durations = steps.map({ $0.duration }) + [finalStepDuration]
        return TimeCalculator.add(durations, to: startTime)
    }
    
    var endTimeString: String {
        return (try? TimeCalculator.formatted(duration: finalStepDuration)) ?? ""
    }
}

struct BakeView: View {
    enum Modal: Identifiable {
        case modify(step: BakeStep)
        case time(label: String, currentTime: Date)
        case duration(label: String, current: Minutes)
        
        var id: String {
            switch self {
            case .modify(let step): return "step." + step.id.uuidString
            case .time(let label, _): return "time." + label
            case .duration(let label, _): return "duration." + label
            }
        }
    }
    
    // Bindings
    @Binding var bake: Bake

    // State
    @State private var modal: Modal? = .none
    
    var body: some View {
        VStack {
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
                    Text(TimeCalculator.formatted(startTime: bake.startTime))
                }
                .background(
                    Button(action: {
                        self.modal = .time(label: "Bake start time",
                                           currentTime: self.bake.startTime)
                    }) {
                        EmptyView()
                    }
                )
                ForEach(bake.steps) { step in
                    BakeStepCell(step: step, start: self.startTime(of: step)) {
                        self.modal = .modify(step: step)
                    }
                }
                .onDelete(perform: remove)
                .onMove(perform: move)
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
                    .sheet(item: $modal,
                           onDismiss: {
                            self.modal = .none
                    }) { modal in
                        return self.view(for: modal)
                    }.foregroundColor(.accentColor)
                    Spacer()
                }
                HStack {
                    Text("Last step duration")
                    Spacer()
                    Text("+ " + bake.endTimeString)
                }
                HStack {
                    Text("Eat & enjoy")
                    Spacer()
                    Text(TimeCalculator.formatted(startTime: bake.endTime))
                }
                
            }
        }
        .navigationBarTitle("Bake")
        .navigationBarItems(trailing: EditButton())
    }
    
    private func view(for modal: Modal?) -> AnyView {
        switch modal {
        case .modify(let step):
            return AnyView (
                ModifyBakeStepView(step: step) { newStep in
                    self.addOrUpdate(step: newStep)
                    self.modal = .none
                }
                .modifier(AppDefaults())
            )
        case .time(let label, let startTime):
            return AnyView(
                SetTimeView(label: label, time: startTime) { newStartTime in
                    self.bake.startTime = newStartTime
                    self.modal = .none
                }
                .modifier(AppDefaults())
            )
        case .duration(_, _):
            return AnyView(EmptyView())
        case .none:
            return AnyView(EmptyView())
        }
    }
    
    private func remove(at offsets: IndexSet) {
        bake.steps.remove(atOffsets: offsets)
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        bake.steps.move(fromOffsets: source, toOffset: destination)
    }
    
    private func addOrUpdate(step: BakeStep) {
        if let index = bake.steps.firstIndex(where: { $0.id == step.id }) {
            bake.steps[index] = step
        } else {
            bake.steps.append(step)
        }
    }
    
    private func startTime(of step: BakeStep) -> Date {
        guard let index = bake.steps.firstIndex(where: { $0.id == step.id }) else { return Date() }
        
        return TimeCalculator.add(bake.steps[0...index].map({ $0.duration }),
                                  to: bake.startTime)
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
    @State private var bake: Bake = Bake(steps: BakeStep.devData)
    
    var body: some View {
        BakeView(bake: $bake)
    }
}

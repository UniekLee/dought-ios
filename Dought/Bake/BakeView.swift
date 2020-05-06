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
    @Binding var bake: Bake
    @State private var isShowingEditModal: Bool = false
    @State private var modifyStep: BakeStep?
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Step")
                    Spacer()
                    Text("Start time")
                }.listRowBackground(Color.gray.opacity(0.2))
                HStack {
                    Text("Begin")
                    Spacer()
                    Text(TimeCalculator.formatted(startTime: bake.startTime))
                }
                ForEach(bake.steps) { step in
                    BakeStepCell(step: step, start: self.startTime(of: step)) {
                        self.modifyStep = step
                    }
                }
                .onDelete(perform: remove)
                .onMove(perform: move)
                HStack {
                    Text("Final step duration")
                    Spacer()
                    Text(bake.endTimeString)
                }
                HStack {
                    Text("Eat & enjoy")
                    Spacer()
                    Text(TimeCalculator.formatted(startTime: bake.endTime))
                }
                
            }
            Button(action: {
                self.modifyStep = .makeNew()
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Add step")
                }
            }
            .padding()
            .sheet(item: $modifyStep,
                   onDismiss: {
                    self.modifyStep = nil
            }) { step in
                ModifyBakeStepView(step: step) { result in
                    guard case .success(let step) = result else { return }
                    self.addOrUpdate(step: step)
                    self.modifyStep = nil
                }
                .modifier(AppDefaults())
            }
        }
        .navigationBarTitle("Bake")
        .navigationBarItems(trailing: EditButton())
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
        WrapperView()
    }
}

fileprivate struct WrapperView: View {
    @State private var bake: Bake = Bake(steps: BakeStep.devData)
    
    var body: some View {
        BakeView(bake: $bake)
    }
}

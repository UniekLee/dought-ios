//
//  DurationPickerView.swift
//  Dought
//
//  Created by Lee Watkins on 15/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI
import Combine

typealias Hours = Int

class DurationPickerViewModel: ObservableObject {
    @Published var duration: Minutes

    @Published var hours: Hours
    @Published var minutes: Minutes
    
    @Published private(set) var minutesSuffix: String = "minutes"
    @Published private(set) var hoursSuffix: String = "hours"
    
    private var cancellables = Set<AnyCancellable>()
    
    init(duration: Minutes) {
        self.hours =    duration / 60
        self.minutes =  duration % 60
        
        self.duration = duration
        
        $hours.map(\.self).map({
            ($0 * 60) + self.minutes
        })
            .assign(to: \.duration, on: self)
            .store(in: &cancellables)
        
        $hours.map(\.self).map({
            "hour" + DurationPickerViewModel.self.pluralSuffix(for: $0)
        })
            .assign(to: \.hoursSuffix, on: self)
            .store(in: &cancellables)

        $minutes.map(\.self).map({
            (self.hours * 60) + $0
        })
            .assign(to: \.duration, on: self)
            .store(in: &cancellables)
        
        $minutes.map(\.self).map({
            "minute" + DurationPickerViewModel.self.pluralSuffix(for: $0)
        })
            .assign(to: \.minutesSuffix, on: self)
            .store(in: &cancellables)
    }
    
    private static func pluralSuffix(for number: Int) -> String {
        if number != 1 {
            return "s"
        } else {
            return ""
        }
    }
}

struct DurationPickerView: View {
    @Binding var duration: Minutes
    
    @ObservedObject private var viewModel: DurationPickerViewModel
    
    init(duration: Binding<Minutes>) {
        self._duration = duration
        viewModel = DurationPickerViewModel(duration: duration.wrappedValue)
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                HStack {
                    Picker("", selection: self.$viewModel.hours) {
                        ForEach(Range(0...24), id: \.self) { Text("\($0)") }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: proxy.size.width/4)
                    .clipped()
                    Text(self.viewModel.hoursSuffix)
                    Spacer()
                }
                .frame(width: proxy.size.width/2)
                
                HStack {
                    Picker("", selection: self.$viewModel.minutes) {
                        ForEach(Range(0...60), id: \.self) { Text("\($0)") }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: proxy.size.width/4)
                    .clipped()
                    Text(self.viewModel.minutesSuffix)
                    Spacer()
                }
                .frame(width: proxy.size.width/2)
            }
        }.onReceive(viewModel.$duration) { duration in
            self.duration = duration
        }
    }
}

struct DurationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        DurationPickerView(duration: .constant(5))
    }
}

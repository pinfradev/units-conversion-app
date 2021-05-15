//
//  ContentView.swift
//  challenge day 19
//
//  Created by Fray Pineda on 15/5/21.
//

import SwiftUI

enum Unit: Int {
    case meter
    case km
    case cm
    case mm
    case inches
}

struct ContentView: View {
    @State private var inputUnitNumber = 0
    @State private var outputUnitNumber = 0
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let unitsArray = ["meter", "km", "cm", "mm", "inches"]
    
    private var result: Double {
        guard let inputUnit = Unit(rawValue: inputUnitNumber) else {
            return 0
        }
        
        guard let outputUnit = Unit(rawValue: outputUnitNumber) else {
            return 0
        }
        
        let output = convertValue(from: inputUnit, to: outputUnit) ?? 0.0
        
        return output
    }
    
    private func getValueInMeters(from unit: Unit) -> Double? {
        var result: Double?
        
        guard let doubleInput = Double(inputValue) else {
            return result
        }
        
        switch unit {
        case .meter:
            result = doubleInput
        case .km:
            result = doubleInput * 1000.0
        case .cm:
            result = doubleInput / 100.0
        case .mm:
            result = doubleInput / 1000.0
        case .inches:
            result = doubleInput / 39.37
        }
        
        return result
    }
    
    private func convertValue(from inputUnit: Unit, to unit: Unit) -> Double? {
        var result: Double?
    
        let inputInMeters = getValueInMeters(from: inputUnit) ?? 0.0
        
        switch unit {
        case .meter:
            result = inputInMeters
        case .km:
            result = inputInMeters / 1000.0
        case .cm:
            result = inputInMeters * 100.0
        case .mm:
            result = inputInMeters * 1000.0
        case .inches:
            result = inputInMeters * 39.37
        }
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("choose input unit")) {
                    Picker("choose input unit", selection: $inputUnitNumber) {
                        ForEach(0 ..< self.unitsArray.count) {
                            Text(unitsArray[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("choose output unit")) {
                    Picker("choose output unit", selection: $outputUnitNumber) {
                        ForEach(0 ..< self.unitsArray.count) {
                            Text(unitsArray[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section() {
                    TextField("Enter input value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Result")) {
                    Text("\(result, specifier: "%.002f")")
                }
            }
            .navigationTitle("length units converter")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  weSplit
//
//  Created by ezz on 01/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var numOfPeople = 2
    @State private var amount:Double?
    @State private var tip:Double = 0
    @FocusState private var amountIsFocused: Bool

    private var tipPercentages: [Double] = [0,5,10,15,20,25]
    
    private var totalPerPerson: Double {
        let peopleCount = Double(numOfPeople + 2)
        let tipSelection = Double(tip)

        let tip = (amount ?? 0) / 100 * tipSelection
        let grandTotal = (amount ?? 0) + tip
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    let currencyFormat = FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("How much is the bill?")
                    .textCase(nil)
                ){
                    TextField("Amount", value: $amount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section(header: Text("How many people?")
                    .textCase(nil)
                ){
                    Picker("Number of people", selection: $numOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section(header: Text("How much tip do you want to leave?")
                    .textCase(nil)
                ){
                    Picker("Tip amount", selection: $tip){
                        ForEach(tipPercentages, id: \.self){
                            Text($0/100, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
            }.navigationTitle("WeSplit").navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            
            Section {
                Text("the total is \(totalPerPerson, format: currencyFormat)")
            }
        }
    }
}


#Preview {
    ContentView()
}

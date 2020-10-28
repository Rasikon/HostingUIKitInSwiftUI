//
//  ContentView.swift
//  HostingUIKitInSwiftUI
//
//  Created by Rasikon on 27.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var alpha = 1.0
    @State private var value = Double.random(in: 0...100)
    @State private var taskValue = Double.random(in: 0...100)
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack{
                Text("Подвиньте слайдер, как можно ближе к:")
                Text("\(lround(taskValue))")
            }
            
            HStack {
                Text("0")
                CustomUISlider(value: $value, alpha: $alpha, taskValue: $taskValue, color: .red)
                Text("100")
            }
            
            Button("Проверь меня", action: {showAlert = true})
                .alert(isPresented: $showAlert,content: {
                    .init(title: Text("Your score!"),
                          message: Text("\(computeScore())"),
                          dismissButton: .default(Text("ОК")))
                })
            
            Button("Начать заново", action: {
                updateView()
            })
        }
        .padding()
    }
    
    private func computeScore() -> Int {
        let difference = abs(lround(taskValue - value))
        return 100 - difference
    }
    
    private func updateView() {
        value = Double.random(in: 0...100)
        taskValue = Double.random(in: 0...100)
        alpha = Double(computeScore()) / 100
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

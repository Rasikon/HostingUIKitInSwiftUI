//
//  CustomUISlider.swift
//  HostingUIKitInSwiftUI
//
//  Created by Rasikon on 27.10.2020.
//

import SwiftUI

struct CustomUISlider: UIViewRepresentable {
    
    @Binding var value: Double
    @Binding var alpha: Double
    @Binding var taskValue: Double
    let color: UIColor
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.thumbTintColor = color.withAlphaComponent(CGFloat(alpha))
        slider.value = Float(value)
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged),
            for: .valueChanged)
        slider.addTarget(context.coordinator,
                         action: #selector(Coordinator.computeAlpha),
                         for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        uiView.thumbTintColor = color.withAlphaComponent(CGFloat(alpha))
    }
    
    func makeCoordinator() -> CustomUISlider.Coordinator {
        Coordinator(value: $value, alpha: $alpha, taskValue: $taskValue)
    }
    
}

extension CustomUISlider {
    class Coordinator: NSObject {
        @Binding var value: Double
        @Binding var alpha: Double
        @Binding var taskValue: Double
        
        init(value: Binding<Double>, alpha: Binding<Double>, taskValue: Binding<Double>) {
            self._value = value
            self._alpha = alpha
            self._taskValue = taskValue
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            value = Double(sender.value)
        }
        
        @objc func computeAlpha(_ sender: UISlider) {
            let difference = abs(lround(taskValue - value))
            alpha = Double(100 - difference)/100
        }
    }
}

struct CustomUISlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomUISlider(value: .constant(30), alpha: .constant(1), taskValue: .constant(40), color: .red)
    }
}

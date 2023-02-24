//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Дмитрий Лубов on 06.02.2023.
//

import UIKit

final class ColorViewController: UIViewController {
    
    @IBOutlet var colorAreaView: UIView!
    
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var colorLabels: [UILabel]!
    
    var color: UIColor!
    unowned var delegate: ColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        for (label, slider) in zip(colorLabels, colorSliders) {
            if slider == sender {
                label.text = string(from: slider)
            }
        }
        
        changeColorView()
    }
    
    @IBAction func doneButtonTapped() {
        guard let backgroundColor = colorAreaView.backgroundColor else { return }
        
        delegate.setColor(for: backgroundColor)
        
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
private extension ColorViewController {
    func updateView() {
        colorAreaView.layer.cornerRadius = 10
        
        updateSlider()
        setValue(for: colorLabels)
        changeColorView()
    }
    
    func updateSlider() {
        guard let components = color.cgColor.components else { return }
        
        if components.count < 4 {
            colorSliders.forEach { $0.value = Float(components.first ?? 0)}
        } else {
            for (slider, component) in zip(colorSliders, components) {
                slider.value = Float(component)
            }
        }
    }
    
    func changeColorView() {
        colorAreaView.backgroundColor = UIColor(
            red: CGFloat(colorSliders[0].value),
            green: CGFloat(colorSliders[1].value),
            blue: CGFloat(colorSliders[2].value),
            alpha: 1
        )
    }
    
    func setValue(for labels: [UILabel]) {
        for (label, slider) in zip(labels, colorSliders) {
            label.text = string(from: slider)
        }
    }
    
    func setValue(for textFields: [UITextField]) {
        for (textField, slider) in zip(textFields, colorSliders) {
            textField.text = string(from: slider)
        }
    }
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

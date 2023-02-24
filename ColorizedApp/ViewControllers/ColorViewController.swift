//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Дмитрий Лубов on 06.02.2023.
//

import UIKit

final class ColorViewController: UIViewController {
    
    @IBOutlet var colorAreaView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var colorLabels: [UILabel]!
    
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorAreaView.layer.cornerRadius = 10
        
        updateSlider()
        setValue()
        changeColorView()
    }

    @IBAction func redSliderAction() {
        let redValue = round(redSlider.value * 100) / 100
        
        redValueLabel.text = redValue.formatted()
        changeColorView()
    }
    
    @IBAction func greenSliderAction() {
        let greenValue = round(greenSlider.value * 100) / 100
        
        greenValueLabel.text = greenValue.formatted()
        changeColorView()
    }
    
    @IBAction func blueSliderAction() {
        let blueValue = round(blueSlider.value * 100) / 100
        
        blueValueLabel.text = blueValue.formatted()
        changeColorView()
    }
}

// MARK: - Private Methods
private extension ColorViewController {
    func changeColorView() {
        colorAreaView.backgroundColor = UIColor(
            red: CGFloat(colorSliders[0].value),
            green: CGFloat(colorSliders[1].value),
            blue: CGFloat(colorSliders[2].value),
            alpha: 1
        )
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
    
    func setValue() {
        for (label, slider) in zip(colorLabels, colorSliders) {
            label.text = string(from: slider)
        }
    }
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

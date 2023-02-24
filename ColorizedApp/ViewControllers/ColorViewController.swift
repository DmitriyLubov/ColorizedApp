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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorAreaView.layer.cornerRadius = 10
        
        redValueLabel.text = redSlider.value.formatted()
        greenValueLabel.text = greenSlider.value.formatted()
        blueValueLabel.text = blueSlider.value.formatted()
        
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
    
    private func changeColorView() {
        colorAreaView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
}


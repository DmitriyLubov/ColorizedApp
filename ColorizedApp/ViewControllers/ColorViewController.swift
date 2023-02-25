//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Дмитрий Лубов on 06.02.2023.
//

import UIKit

final class ColorViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var colorAreaView: UIView!
    
    @IBOutlet var colorLabels: [UILabel]!
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var colorTextFields: [UITextField]!
    
    @IBOutlet var toolbar: UIToolbar!
    
    var color: UIColor!
    unowned var delegate: ColorViewControllerDelegate!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        setValue(for: colorLabels, sender)
        setValue(for: colorTextFields, sender)
        
        changeColorView()
    }
    
    @IBAction func doneButtonTapped() {
        view.endEditing(true)
        
        guard !(presentedViewController is UIAlertController) else { return }
        guard let backgroundColor = colorAreaView.backgroundColor else { return }
        
        delegate.setColor(for: backgroundColor)
        dismiss(animated: true)
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
}

// MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text else { return }
        guard let numberValue = Float(value) else {
            showAlert(
                title: "Wrong format!",
                message: "Please enter correct value",
                textField: textField
            )
            return
        }
        
        for (slider, colorTextField) in zip(colorSliders, colorTextFields) {
            if colorTextField == textField {
                slider.setValue(numberValue, animated: true)
                
                setValue(for: colorLabels, slider)
                setValue(for: colorTextFields, slider)
                
                break
            }
        }
        
        changeColorView()
    }
}

// MARK: - UIAlertController
private extension ColorViewController {
    func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "1.00"
            textField?.becomeFirstResponder()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Private Methods
private extension ColorViewController {
    func setupView() {
        colorAreaView.layer.cornerRadius = 10
        toolbar.removeFromSuperview()
        
        colorTextFields.forEach { textField in
            textField.delegate = self
            textField.inputAccessoryView = toolbar
        }
        
        setValue(for: colorSliders, color)
        setValue(for: colorLabels)
        setValue(for: colorTextFields)
        changeColorView()
    }
    
    func setValue(for sliders: [UISlider], _ color: UIColor) {
        guard var components = color.cgColor.components else { return }
        
        if components.count == 2, let fistElement = components.first {
            components.insert(contentsOf: [fistElement, fistElement], at: 1)
        }
        
        for (slider, component) in zip(colorSliders, components) {
            slider.value = Float(component)
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
    
    func setValue(for labels: [UILabel], _ slider: UISlider? = nil) {
        for (label, colorSlider) in zip(labels, colorSliders) {
            if colorSlider == slider ?? colorSlider {
                label.text = string(from: colorSlider)
            }
        }
    }
    
    func setValue(for textFields: [UITextField], _ slider: UISlider? = nil) {
        for (textField, colorSlider) in zip(textFields, colorSliders) {
            if colorSlider == slider ?? colorSlider {
                textField.text = string(from: colorSlider)
            }
        }
    }
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

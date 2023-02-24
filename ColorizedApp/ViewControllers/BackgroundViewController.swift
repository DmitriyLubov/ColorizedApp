//
//  BackgroundViewController.swift
//  ColorizedApp
//
//  Created by Дмитрий Лубов on 24.02.2023.
//

import UIKit

protocol ColorViewControllerDelegate: AnyObject {
    func setColor(for backgroundColor: UIColor)
}

final class BackgroundViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorVC = segue.destination as? ColorViewController else { return }

        colorVC.color = view.backgroundColor
        colorVC.delegate = self
    }
}

extension BackgroundViewController: ColorViewControllerDelegate {
    func setColor(for backgroundColor: UIColor) {
        view.backgroundColor = backgroundColor
    }
}

//
//  BackgroundViewController.swift
//  ColorizedApp
//
//  Created by Дмитрий Лубов on 24.02.2023.
//

import UIKit

final class BackgroundViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorVC = segue.destination as? ColorViewController else { return }

        colorVC.color = view.backgroundColor
    }
}

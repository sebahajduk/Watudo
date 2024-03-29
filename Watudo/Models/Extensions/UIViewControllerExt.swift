//
//  UIViewControllerExt.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 28/02/2023.
//

import UIKit

extension UIViewController {

    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        self.present(alert, animated: true)
    }

    func presentAlert(_ error: any Error) {
        let alert = UIAlertController(title: "Something went wrong",
                                      message: error.localizedDescription,
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        self.present(alert, animated: true)
    }

}

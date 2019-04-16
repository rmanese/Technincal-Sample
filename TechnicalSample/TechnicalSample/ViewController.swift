//
//  ViewController.swift
//  TechnicalSample
//
//  Created by Roberto Manese III on 4/15/19.
//  Copyright © 2019 jawnyawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var returnStringLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cutStringButton: UIButton!

    var manager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        cutStringButton.addTarget(self, action: #selector(didTapCutStringButton), for: .touchUpInside)
        cutStringButton.layer.borderColor = UIColor.black.cgColor
        cutStringButton.layer.borderWidth = 2
        cutStringButton.layer.cornerRadius = 15
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 15
    }

    @objc func didTapCutStringButton() {
        guard let text = textField.text else { return }
        manager.cutStringRequest(input: text) { (returnString, _) in
            guard let text = returnString else { return }
            DispatchQueue.main.async {
                self.returnStringLabel.text = "\(text.returnString)"
                self.textField.text = ""
            }
        }
    }


}


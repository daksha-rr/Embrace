//
//  ViewController.swift
//  Embrace
//
//  Created by Daksha Rajagopal on 1/30/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "dashboard")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
    
}

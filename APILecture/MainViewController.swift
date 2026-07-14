//
//  ViewController.swift
//  APILecture
//
//  Created by Misha on 13.07.2026.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var funFactLabel: UILabel!
    
    private var apiManager: FunFactAPIManagerProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFunFactManager()
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapRandomFunFact(_ sender: Any) {
        spinner.isHidden = false
        setUpFunFactManager()
        spinner.isHidden = true
    }
    
    private func setUpFunFactManager() {
        apiManager = FunFactAPIManager()
        apiManager?.fetchFunFact {  funfact in
            self.funFactLabel.text = funfact.value
            
        }
    }
}


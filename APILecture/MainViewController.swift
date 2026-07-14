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
        spinner.isHidden = false
        setUpFunFactManager(param: "")
        spinner.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapRandomFunFact(_ sender: Any) {
        spinner.isHidden = false
        setUpFunFactManager(param: "")
        spinner.isHidden = true
    }
    @IBAction func didTapAnimalJokes(_ sender: Any) {
        spinner.isHidden = false
        setUpFunFactManager(param: "category=animal")
        spinner.isHidden = true
    }
    
    @IBAction func didTapCareerJokes(_ sender: Any) {
        spinner.isHidden = false
        setUpFunFactManager(param: "category=career")
        spinner.isHidden = true
    }
    private func setUpFunFactManager(param: String) {
        apiManager = FunFactAPIManager(param: param)
        apiManager?.fetchFunFact {  funfact in
            self.funFactLabel.text = funfact.value
            
        }
    }
}


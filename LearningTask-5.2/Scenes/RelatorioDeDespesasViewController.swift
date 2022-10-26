//
//  ViewController.swift
//  LearningTask-5.2
//
//  Created by rafael.rollo on 15/03/2022.
//

import UIKit

class RelatorioDeDespesasViewController: UIViewController {
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var tipoTextField: UITextField!
    @IBOutlet weak var valorTextField: UITextField!
    
    @IBOutlet weak var listaDeDespesasView: ListaDeDespesasView!
    @IBOutlet weak var valorTotalLabel: UILabel!
    
    @IBOutlet weak var registraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func botaoAdicionarDespesaPressionado(_ sender: UIButton) {
    }
    
    @IBAction func botaoRegistrarDespesasPressionado(_ sender: UIButton) {
        print("Vai para uma tela de revisão...")
    }
}


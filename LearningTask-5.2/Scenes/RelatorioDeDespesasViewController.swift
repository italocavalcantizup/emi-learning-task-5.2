//
//  ViewController.swift
//  LearningTask-5.2
//
//  Created by rafael.rollo on 15/03/2022.
//

import UIKit

class RelatorioDeDespesasViewController: UIViewController {
    
    typealias MensagemDeErro = String
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var tipoTextField: UITextField!
    @IBOutlet weak var valorTextField: UITextField!
    
    @IBOutlet weak var listaDeDespesasView: ListaDeDespesasView!
    @IBOutlet weak var valorTotalLabel: UILabel!
    
    @IBOutlet weak var registraButton: UIButton!
    
    var relatorioDeDespesas: RelatorioDeDespesas? {
        didSet {
            guard isViewLoaded, let relatorioDeDespesas = relatorioDeDespesas else { return }
            atualizaViews(para: relatorioDeDespesas)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let relatorioDeDespesas = relatorioDeDespesas {
            atualizaViews(para: relatorioDeDespesas)
        }
        
        switch formularioEhValido() {
        case (false, let mensagem):
            exibeAlerta(para: mensagem)
        default:
            adicionaDespesa()
        }
        
    }
    
    func exibeAlerta(para mensagemDeErro: MensagemDeErro?) {
        let alert = UIAlertController(
            title: "Erro",
            message: mensagemDeErro ?? "Verifique os dados informados e tente novamente.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func formularioEhValido() -> (Bool, MensagemDeErro?) {
        if let titulo = tituloTextField.text, titulo.isEmpty {
            return (false, "Título inválido")
        }
        
        guard let tipoComoTexto = tipoTextField.text,
              let tipo = Int(tipoComoTexto),
              let _ = Despesa.Tipo(rawValue: tipo) else {
            return (false, "Tipo de despesa inválido")
        }
        
        guard let valorEmTexto = valorTextField.text,
              let _ = Converter.paraDecimal(string: valorEmTexto) else {
            return (false, "Valor inválido")
        }
        
        return (true, nil)
    }
    
    @IBAction func botaoAdicionarDespesaPressionado(_ sender: UIButton) {
        switch formularioEhValido() {
        case (false, let mensagem):
            exibeAlerta(para: mensagem)
        default:
             adicionaDespesa()
        }
    }
    
    func adicionaDespesa() {
        let codigo = Int(tipoTextField.text!)!
        let tipo = Despesa.Tipo(rawValue: Int(codigo))!
        
        let despesa = Despesa(titulo: tituloTextField.text!,
                              tipo: tipo,
                              valor: Converter.paraDecimal(string: valorTextField.text!)!)
        
        relatorioDeDespesas?.adiciona(despesa)
    }
    
    func atualizaViews(para relatorio: RelatorioDeDespesas) {
        listaDeDespesasView.atualiza(relatorio.despesas)
        
        valorTotalLabel.text = Formatter.paraMoeda(decimal: relatorio.valorTotal)
        registraButton.isEnabled = relatorio.valorTotal > 0
    }
    
    @IBAction func botaoRegistrarDespesasPressionado(_ sender: UIButton) {
        print("Vai para uma tela de revisão...")
    }
}


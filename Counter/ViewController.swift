//
//  ViewController.swift
//  Counter
//
//  Created by Dmitrii Pogonia on 16.02.2026.
//

import UIKit

class ViewController: UIViewController {
    private var counter: Int = 0
    
    @IBAction func didTapPlusButton(_ sender: Any) {
        counter += 1
        appendToHistory("значение изменено на +1")
        updateLabel()
    }
    @IBAction func didTapMinusButton(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            appendToHistory("значение изменено на -1")
            updateLabel()
        } else {
            appendToHistory("попытка уменьшить значение счётчика ниже 0")
        }
        
    }
    @IBAction func didTapResetButton(_ sender: Any) {
        counter = 0
        appendToHistory("значение сброшено")
        updateLabel()
    }
    
    @IBOutlet weak var plusUIButton: UIButton!
    @IBOutlet weak var resetUIButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var minusUIButton: UIButton!
    @IBOutlet weak var historyUITextView: UITextView!
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter
    }()
    
    private func appendToHistory(_ message: String) {
        let time = dateFormatter.string(from: Date())
        let entry = "\(time): \(message)\n"
        historyUITextView.text += entry
    }
    
    
    private func updateLabel() {
        counterLabel.text = "Значение счетчика: \(counter)"
    }
    
    private func setupUI() {
        // Label
        counterLabel.layer.cornerRadius = 12
        counterLabel.layer.masksToBounds = true
        
        // Buttons
        plusUIButton.setTitle("+", for: .normal)
        plusUIButton.tintColor = .white
        minusUIButton.setTitle("-", for: .normal)
        minusUIButton.tintColor = .white
        resetUIButton.setImage( UIImage(systemName: "xmark.circle.fill"), for: .normal)
        resetUIButton.tintColor = .white
        
        // History
        historyUITextView.text = "История изменений: \n"  // Начальный текст
        historyUITextView.isEditable = false
        historyUITextView.isScrollEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        updateLabel()
    }
}


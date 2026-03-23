//
//  ViewController.swift
//  Counter
//
//  Created by Dmitrii Pogonia on 16.02.2026.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var historyUITextView: UITextView!
    @IBOutlet weak private var counterLabel: UILabel!
    @IBOutlet weak private var plusButton: UIButton!
    @IBOutlet weak private var minusButton: UIButton!
    @IBOutlet weak private var resetButton: UIButton!
    
    // MARK: - Private Properties
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter
    }()
    
    private var counter: Int = 0
    private var counterArray: [Int] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadedCount = UserDefaults.standard.integer(forKey: "counterValue")
        counter = loadedCount
        
        let loadedHistory = UserDefaults.standard.stringArray(forKey: "counterHistory") ?? []

        setupUI()
        updateUI()
        
        historyUITextView.text = "История изменений:\n" + loadedHistory.joined(separator: "\n")
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapPlusButton(_ sender: Any) {
        counter += 1
        appendText("значение изменено на +1")
        updateUI()
    }
    @IBAction private func didTapMinusButton(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            appendText("значение изменено на -1")
            UserDefaults.standard.set(counter, forKey: "counterValue")
            UserDefaults.standard.set(counterArray, forKey: "counterHistory")
            updateUI()
        } else {
            appendText("попытка уменьшить значение счётчика ниже 0")
        }
    }
    @IBAction private func didTapResetButton(_ sender: Any) {
        counter = 0
        appendText("значение сброшено")
        updateUI()
    }
    
    // MARK: - Private Methods
    
    private func updateUI() {
        counterLabel.text = "Значение счетчика: \(counter)"
    }
    private func setupUI() {
        // Label
        counterLabel.layer.cornerRadius = 12
        counterLabel.layer.masksToBounds = true
        
        // Buttons
        plusButton.setTitle("+", for: .normal)
        plusButton.tintColor = .white
        minusButton.setTitle("-", for: .normal)
        minusButton.tintColor = .white
        resetButton.setImage( UIImage(systemName: "xmark.circle.fill"), for: .normal)
        resetButton.tintColor = .white
        
        // History
        historyUITextView.text = "История изменений: \n"
        historyUITextView.isEditable = false
        historyUITextView.isScrollEnabled = true
    }
    
    private func appendText(_ message: String) {
        // 1. Создаем дату и текст записи
        let time = dateFormatter.string(from: Date())
        let entry = "[\(time)]: \(message)\n"
        
        // 2. Добавляем текст в UITextView
        historyUITextView.text += entry
        
        // 3. Прокручиваем вниз
        let bottom = NSRange(location: historyUITextView.text.count - 1, length: 1)
        historyUITextView.scrollRangeToVisible(bottom)
        
        // Если хочешь оставить лог в консоли для "пустой" истории:
        // print("No history yet") // Это не вызовет ошибку
    }
}

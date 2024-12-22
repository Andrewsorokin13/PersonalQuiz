//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Андрей Сорокин on 12.12.2024.
//

import UIKit

final class ResultViewController: UIViewController {
    
    //MARK: - IB Outlets
    
    @IBOutlet var animalLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Property
    
    var answers: [Answer]!
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    // MARK: - IB Actions private methods
    
    @IBAction private func restartQuiz() {
        dismiss(animated: true)
    }
}

// MARK: - Private Extension

private extension ResultViewController {
    
    func updateUI () {
        navigationItem.hidesBackButton = true
        
        guard let animal = findMostFrequentAnimal() else { return  }
        showResultAnswers(animal)
    }
    
    func  findMostFrequentAnimal() -> Animal? {
        var animalCount: [Animal: Int] = [:]
        
        for answer in answers {
            animalCount[answer.animal, default: 0] += 1
        }
        return animalCount.max { $0.value < $1.value }?.key
    }
    
    func showResultAnswers(_ animal: Animal) {
        animalLabel.text = "Вы - \(animal.rawValue)!"
        descriptionLabel.text = animal.description
    }
}

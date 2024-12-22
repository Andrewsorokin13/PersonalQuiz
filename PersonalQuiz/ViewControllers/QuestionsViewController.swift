//
//  QuestionsViewController.swift
//  PersonalQuiz
//
//  Created by Андрей Сорокин on 12.12.2024.
//

import UIKit

final class QuestionsViewController: UIViewController {
    
    //MARK: - IB Outlets
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet weak var rangedSlider: UISlider!
    
    //MARK: - Private property
    private let questions = Questions.getQuestions()
    private var answersChosen: [Answer] = []
    private var questionIndex = 0
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let answerCount = Float(currentAnswers.count - 1)
        rangedSlider.maximumValue = answerCount
        rangedSlider.value = answerCount / 2
        
        updateUI()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as? ResultViewController
        resultVC?.answers = answersChosen
    }
    
    //MARK: - IB Action private methods
    
    @IBAction private func singleButtonAnswerPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let answer = currentAnswers[buttonIndex]
        answersChosen.append(answer)
        showNextQuestion()
    }
    
    @IBAction private func multipleButtonAnswerPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        showNextQuestion()
    }
    
    @IBAction private func rangedAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        showNextQuestion()
    }
}

//MARK: - Extension для обновления UI

private extension QuestionsViewController {
    func updateUI() {
        
        // Скрытие всех стековых представлений
        [singleStackView, multipleStackView, rangedStackView].forEach {
            $0?.isHidden = true
        }
        
        // Получение текущего вопроса
        let currentQuestion = questions[questionIndex]
        
        // Обновление текста вопроса и прогресса
        questionLabel.text = questions[questionIndex].title
        let totalProgress = Float(questionIndex) / Float(questions.count)
        questionProgressView.setProgress(totalProgress, animated: true)
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // Отображение вариантов ответа для текущего типа вопроса
        showCurrentAnswers(for: currentQuestion.answerType)
    }
    
    func showCurrentAnswers(for type: AnswerType) {
        switch type {
        case .single:
            showSingleStackView(currentAnswers)
        case .multiple:
            showMultipleStackView(currentAnswers)
        case .range:
            showRangeStackView(currentAnswers)
        }
    }
    
    func showSingleStackView(_ answer: [Answer]) {
        singleStackView.isHidden = false
        for (button, answer) in zip(singleButtons, answer) {
            let title = answer.title
            button.setTitle(title, for: .normal)
        }
    }
    
    func showMultipleStackView(_ answer: [Answer]) {
        multipleStackView.isHidden = false
        for (label, answer) in zip(multipleLabels, answer) {
            label.text = answer.title
        }
    }
    
    func showRangeStackView(_ answer: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLabels.first?.text = answer.first?.title
        rangedLabels.last?.text = answer.last?.title
    }
    
    func showNextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: Constants.segueResultID, sender: nil)
    }
}

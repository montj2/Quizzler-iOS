//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressLabel.text = "\(questionNumber)/\(allQuestions.list.count)"

        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if (sender.tag == 1) {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1
        nextQuestion()
        
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1)/\(allQuestions.list.count)"
        //progressConstraint.constant = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
        
    }
    

    func nextQuestion() {
        
        if (questionNumber < allQuestions.list.count) {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            
            let alert = UIAlertController(title: "Awesome", message: "You have answered all the questions! Would you like to play again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if (correctAnswer == pickedAnswer) {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        } else {
            ProgressHUD.showError("Wrong!")
            print("Wrong!")
        }
        
        updateUI()
        
    }
    
    
    func startOver() {
        
        questionNumber = 0
        score = 0
        nextQuestion()
       
    }
    

    
}

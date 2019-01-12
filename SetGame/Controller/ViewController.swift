//
//  ViewController.swift
//  SetGame
//
//  Created by Sara Elsayed Salem on 1/10/19.
//  Copyright © 2019 mac. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var deal3MoreCard: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBAction func newGame(_ sender: UIButton) {
        game.startNewGame(numberOfSetCards: numberOfSetCards)
        startGame()
        scoreValue = 0
        deal3MoreCard.isEnabled = true
    }
    func startGame(){
        for index in 0...11 {
            drawCards(on:index,isHidden:false)
        }
        for index in 12...23{
            let button = cardButtons[index]
            button.isHidden = true
        }
        updateViewFromModel()
    }
    func dealThreeMoreCard(){
        if game.cardsToAppearsLater.count > 0{
            for _ in 0...2 {
                let card = game.getCard()
                drawCards(on:card.id,isHidden:false)
            }
        }
        if game.cardsToAppearsLater.count == 0{
            deal3MoreCard.isEnabled = false
        }
    }
    @IBAction func deal3MoreCard(_ sender: UIButton) {
        dealThreeMoreCard()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    private var dictionaryOfRelatedData = [Card:[String:Any]]()
    func drawCards(on index :Int , isHidden:Bool){
            let button = cardButtons[index]
            let card = game.cards[index]
        let numer = card.number.numberVal
            var noOfShapes = ""
            for _ in  1...numer {
                noOfShapes += card.shape.shapeVal
            }
        let cardcolor = card.color.colorVal
            var colorWithShading : UIColor;
            switch cardcolor {
                case "blue" : colorWithShading = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                case "brown" : colorWithShading = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                case "black" : colorWithShading = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                default: colorWithShading = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
            let shading = card.shading
            setTitle(of : button,with: noOfShapes,andColor: colorWithShading.withAlphaComponent(CGFloat(shading.shadingVal["alpha"]!))
                , andStroke : CGFloat(shading.shadingVal["stroke"]!))
            button.layer.cornerRadius = 8.0
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            if !isHidden {
                button.isHidden = isHidden
            }
    }
    private func setTitle(of button : UIButton , with title : String , andColor: UIColor, andStroke:CGFloat){
        let font = UIFont.systemFont(ofSize: 23)
        let attributes: [NSAttributedString.Key:Any] = [
            .font : font,
            .foregroundColor: andColor,
            .strokeWidth : andStroke
        ]
        let myNormalAttributedTitle = NSAttributedString(string: title,attributes: attributes)
        button.setAttributedTitle(myNormalAttributedTitle, for: .normal)
    }
    private func updateViewFromModel (){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isMatched {
                button.backgroundColor =  #colorLiteral(red: 0.9397521615, green: 1, blue: 0.9613415599, alpha: 0) ;
                button.setTitle("", for: .normal)
                button.setAttributedTitle(nil, for: .normal)
                button.layer.borderColor = UIColor.white.cgColor
                button.layer.borderWidth = 0.0
                
            }else{
                //for selected
                if game.arrOfSelectedCards.count > 0 && game.arrOfSelectedCards.contains(card){
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.blue.cgColor
                }else{
                    button.layer.borderColor = UIColor.white.cgColor
                    button.layer.borderWidth = 0.0
                }
            }
        }
    }
    private var numberOfSetCards:Int{
        return cardButtons.count
    }
    private lazy var game = Set(numberOfSetCards: numberOfSetCards)

    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func selectCard(_ sender: UIButton) {
        
        if let cardIndex = cardButtons.index(of: sender){
            game.selectCard(at: cardIndex){ [unowned self] (result,type) in
                    self.scoreValue += result
                if type == Set.Result.match {
                    self.dealThreeMoreCard()
                }
            }
            updateViewFromModel()
        }
    }
    private func updateScoreLabel(){
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor : UIColor.orange
        ]
        let attribText = NSAttributedString(string: "Score: \(scoreValue)", attributes: attributes)
        scoreLabel.attributedText = attribText
    }
    private(set) var scoreValue = 0 { //property observer
        didSet {
            updateScoreLabel()
        }
    }
}
extension Int{
    var arc4random : Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{ // = zero
            return 0
        }
    }
}

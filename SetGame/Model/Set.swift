//
//  Set.swift
//  SetGame
//
//  Created by Sara Elsayed Salem on 1/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class Set {
    
    enum Result : Int{
        case match = 3
        case mismatch = -5
        case deselection = -1
    }
    
    private(set)  var cards  = [Card]()
    private(set) var cardsToAppearsLater = [Card]()
    
    func startNewGame(numberOfSetCards : Int){
        cards = []
        cardsToAppearsLater = []
        for index in 0..<numberOfSetCards {
            let card = Card(isMatched: false,shape:Set.randomShape,shading:Set.randomShading,color:Set.randomColor,number:Set.randomNumber,id:index)
            if index > 11 {
                cardsToAppearsLater.append(card)
            }
            cards.append(card)
        }
    }
    
    static  var randomShape : Card.Shape {
        return Card.Shape.allShapes[Card.Shape.allShapes.count.arc4random];
    }
    static var randomColor : Card.Color {
        return Card.Color.allColors[Card.Color.allColors.count.arc4random];
    }
    static var randomShading : Card.Shading {
        return Card.Shading.allShading[Card.Shading.allShading.count.arc4random];
    }
    static var randomNumber : Card.Number {
        return Card.Number.allNumbers[Card.Number.allNumbers.count.arc4random];
    }
    func getCard() -> Card{
         return cardsToAppearsLater.remove(at: 0)
    }
        
    
    init(numberOfSetCards : Int) {
        startNewGame(numberOfSetCards : numberOfSetCards)
    }
    private(set) var arrOfSelectedCards = [Card]()
    //matching algorithm // incase matching display another 3 cards
    func selectCard(at index : Int ,matching result : @escaping  (Int,Result)->Void) {
        if arrOfSelectedCards.contains(cards[index]){
            //user want to deselect//
            arrOfSelectedCards.remove(at:arrOfSelectedCards.index(of:cards[index])!)
             result(Result.deselection.rawValue,.deselection)
        }else{
            //user want to select//
            arrOfSelectedCards.append(cards[index])
        }
        //to put blue border for selected card
        if arrOfSelectedCards.count == 3 {
            if(isSetMatched(card1: arrOfSelectedCards[0], card2: arrOfSelectedCards[1], card3: arrOfSelectedCards[2])){
                cards[cards.index(of:arrOfSelectedCards[0])!].isMatched = true
                cards[cards.index(of:arrOfSelectedCards[1])!].isMatched = true
                cards[cards.index(of:arrOfSelectedCards[2])!].isMatched = true
                
                arrOfSelectedCards = []
                result(Result.match.rawValue,.match)
            }else{
                arrOfSelectedCards = []
               result(Result.mismatch.rawValue,.mismatch)
            }
        }
    }
    private func isSetMatched( card1:Card,  card2:Card,  card3:Card)  -> Bool {
    if(!areAllEqual(card1.number.rawValue, card2.number.rawValue, card3.number.rawValue) && !areAllDifferent(card1.number.rawValue, card2.number.rawValue, card3.number.rawValue)){
        return false;
    }
    if(!areAllEqual(card1.shape.rawValue, card2.shape.rawValue, card3.shape.rawValue) && !areAllDifferent(card1.shape.rawValue, card2.shape.rawValue, card3.shape.rawValue)){
        return false;
    }
    if(!areAllEqual(card1.shading.rawValue, card2.shading.rawValue, card3.shading.rawValue) && !areAllDifferent(card1.shading.rawValue, card2.shading.rawValue, card3.shading.rawValue)){
        return false;
    }
    if(!areAllEqual(card1.color.rawValue, card2.color.rawValue, card3.color.rawValue) && !areAllDifferent(card1.color.rawValue, card2.color.rawValue, card3.color.rawValue)){
        return false;
    }
        return true;
    }
    private func areAllEqual(_ val1:String,_ val2:String, _ val3:String) -> Bool{
        return val1 == val2 && val2 == val3;
    }
    private func areAllDifferent(_ val1:String,_ val2:String, _ val3:String)-> Bool{
        return val1 != val2 && val2 != val3 && val1 != val3;
    }

}



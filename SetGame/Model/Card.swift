//
//  Card.swift
//  SetGame
//
//  Created by Sara Elsayed Salem on 1/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct Card :Hashable {
    
    var hashValue: Int {return id}
    
    var isMatched : Bool = false
    var shape:Shape
    var shading:Shading
    var color:Color
    var number:Number
    var id:Int
    
    enum Shape:String,CustomStringConvertible {
        
        var description: String{
            return rawValue
        }
        case square = "■"
        case circle = "●"
        case triangle = "▲"
        
        var shapeVal: String {
            switch self {
            case .square : return "■"
            case .circle : return "●"
            case .triangle :  return "▲"
            }
        }
        
        static var allShapes = [Shape.square,.circle,.triangle]
    }
    enum Shading :String,CustomStringConvertible{
        
        var description: String{
            return rawValue
        }
        case filled = "filled"
        case opened = "opened"
        case striped = "striped"
        
        var shadingVal: [String:Float] {
            switch self {
            case .filled : return ["alpha":1.0,"stroke":0.0]
            case .opened : return ["alpha":1.0,"stroke":5.0]
            case .striped :  return ["alpha": 0.35,"stroke":0.0]
            }
        }
        
        static var allShading = [Shading.filled,.opened,.striped]
        
    }
    
    enum Color:String ,CustomStringConvertible{
        var description: String{
            return rawValue
        }
        
        case black = "black"
        case blue = "blue"
        case brown = "brown"
        
        var colorVal: String {
            switch self {
            case .black : return "black"
            case .blue : return "blue"
            case .brown :  return "brown"
            }
        }
        
        static var allColors = [Color.black,.blue,.brown]
    }
    enum Number:String , CustomStringConvertible {
        var description: String{
            return rawValue
        }
        case one = "1"
        case two = "2"
        case three = "3"
        
        var numberVal: Int {
            switch self {
            case .one : return 1
            case .two : return 2
            case .three :  return 3
            }
        }
        
        static var allNumbers = [Number.one,.two,.three]
    }
    
}

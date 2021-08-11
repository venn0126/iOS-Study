//: A UIKit based Playground for presenting user interface
  

import Foundation

/**
let p = UnsafeMutableRawPointer.allocate(byteCount: 4 * 8, alignment: 8)
defer {
    p.deallocate()
}

for i in 0..<4 {
    p.advanced(by: i * 8).storeBytes(of: i, as: Int.self)
}
let offset = 8 * 4
print(p.advanced(by: offset).load(as: Int.self))

class Document {
    
    var name: String?
    
    init() {}
    
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class AutoDoc: Document {
    
//    override init() {
//        super.init()
//        self.name = "[Untitled]"
//    }
    
    override init() {
        super.init(name: "[Untitled]")!
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[untitled]"
        } else {
            self.name = name
        }
    }
}

*/

/// Protocol
protocol FullyName {
    
    var fullName: String { get }
}

struct Person: FullyName {
    
    var fullName: String
}

let p = Person(fullName: "augus venn")
print(p.fullName)


/// property requirements
class StarShip: FullyName {
    
    
    // instance properties
    var prefix: String?
    var name: String
    
    // instance compute property
    var fullName: String {
        return ((prefix != nil) ? prefix! : "") + name
    }
    
    // initialization method
    init(name: String,prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
}

let s1 = StarShip(name: "niu")
s1.fullName
let s2 = StarShip(name: "niu", prefix: "wei")
s2.fullName

/// Method requirements

protocol RandomNumberGenerate {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerate {
    
    //property
    var lastRandom = 42.0
    let a = 139968.0
    let m = 3877.0
    let c = 29573.0
    
    
    // protocol method
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
}


let generator = LinearCongruentialGenerator()
print(generator.random())
print(generator.random())
print(generator.random())

/// Mutaing method requirement
protocol Togglable {
    mutating func toggle()
}

enum OneSwitch: Togglable {
    
    case on,off
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}


var one = OneSwitch.off
one.toggle()
one.toggle()

/// Initialization requiremnt

protocol SomeProtol {
    init()
}

class BaseClass {
    init() {
        
    }
}

class someClass: BaseClass, SomeProtol {
    
   override required init() {
        
    }
}


/// Protocol as type
class Dice {
    
    let sides: Int
    let generator: RandomNumberGenerate
    
    init(sides: Int,generator: RandomNumberGenerate) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
    
}

let dice = Dice(sides: 3, generator: LinearCongruentialGenerator())
for _ in 1..<5 {
    print("random dice is \(dice.roll())")
}

/// Delegation
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

/// Only class to adopt
protocol DiceGameDelegate: AnyObject {
    
    // Start game method
    func gameDidStart(_ game: DiceGame)
    // Dice start turn
    func game(_ game: DiceGame,didStartNewTurnWithDiceRolldiceRoll diceRoll: Int)
    // End game
    func gameDidEnd(_ game: DiceGame)
    
}

class SnakesAndLadders: DiceGame {
    
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[0] = +08;board[06] = +11;board[09] = +09
        board[10] = +02;board[14] = -10;board[19] = -11;
        board[22] = -02;board[24] = -08
    }
    
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRolldiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue
            
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
    
}


class DiceGameTracker: DiceGameDelegate {
 
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("start a new dice game")
        }
        
        print("The gam is use \(game.dice.sides)")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRolldiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Roll a \(diceRoll)")
    }
    
    
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

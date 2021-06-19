//
//  ViewController.swift
//  Flips
//
//  Created by Alexander Kovzhut on 19.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var touchesLabel: UILabel!

    @IBOutlet var buttonCollection: [UIButton]!
    
    lazy var game = ConcentrationGame(numberOfPairsCards: (buttonCollection.count + 1) / 2)
    
    var touches = 0 {
        didSet{
            touchesLabel.text = "Touches: \(touches)"
        }
    }
    
    var emojiCollection = ["🐖","🦨","🐈","🐄","🦙","🐪","🐃","🐏","🐘","🐓","🦔","🦒"]
    
    var emojiDictionary = [Int:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
            
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            }
        }
    }

    @IBAction func actionButton(_ sender: UIButton) {
        touches += 1
        
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
    
}


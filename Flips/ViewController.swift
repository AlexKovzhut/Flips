//
//  ViewController.swift
//  Flips
//
//  Created by Alexander Kovzhut on 19.06.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var touchesLabel: UILabel ! {
        didSet {
           updateTouches()
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    
    private lazy var game = ConcentrationGame(numberOfPairsCards: numberOfPairsCards)
    
    var numberOfPairsCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
    private func updateTouches() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 4.0,
            .strokeColor: UIColor.yellow
        ]
        let attributesString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
        touchesLabel.attributedText = attributesString
    }
    
    private(set) var touches = 0 {
        didSet{
            updateTouches()
        }
    }
    
    private var emojiCollection = "🐖🦨🐈🐄🦙🐪🐃🐏🐘🐓🦔🦒"
    
    private var emojiDictionary = [Card:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            let randomStringIndex = emojiCollection.index(
                emojiCollection.startIndex,
                offsetBy: emojiCollection.count.arc4randomExtension
            )
            emojiDictionary[card] = String(emojiCollection.remove(at: randomStringIndex))
        }
        return emojiDictionary[card] ?? "?"
    }
    
    private func updateViewFromModel() {
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

    @IBAction private func actionButton(_ sender: UIButton) {
        touches += 1
        
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
}

extension Int {
    var arc4randomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}


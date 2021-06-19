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
    
    //Property Observers
    var touches = 0 {
        didSet{
            touchesLabel.text = "Touches: \(touches)"
        }
    }
    
    let emojiCollection = ["❤️","♠️","♦️","♣️"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func flipButton(emoji: String, button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        }
    }

    @IBAction func actionButton(_ sender: UIButton) {
        touches += 1
        
        //Optional Binding
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            flipButton(emoji: emojiCollection[buttonIndex], button: sender)
        }
    }
    
}


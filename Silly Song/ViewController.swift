//
//  ViewController.swift
//  Silly Song
//
//  Created by Tiago Missão on 19/07/17.
//  Copyright © 2017 missao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }
    
    // MARK: - UIActions

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


/// Gets the short version of a given name
/// This method removes all the consonants before the first vowel
///
/// - Parameter name: name that will become shortened
/// - Returns: short version of the given name
func shortNameFromName(_ name:String) -> String {
    let lowercase = name.lowercased()
    let vowels = CharacterSet(charactersIn: "aeioöu")
    let index = lowercase.rangeOfCharacter(from: vowels, options: .caseInsensitive, range: lowercase.startIndex ..< lowercase.endIndex)
    
    if index != nil {
        return lowercase.substring(from: index!.lowerBound)
        
    }
    
    return lowercase
}


/// Gets a music template replacing the tag "<FULL_NAME>" and "<SHORT_NAME>" by 
/// the given fullName and the short version of fullname respectively.
///
/// - Parameters:
///   - lyricsTemplate: music template
///   - fullName: name that will be add on template
/// - Returns: music lyric
func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(fullName)
    let replacedFullName = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    return replacedFullName.replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
}

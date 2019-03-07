//
//  GameViewController.swift
//  CoreDataSuperExample
//
//  Created by MAC Consultant on 3/5/19.
//  Copyright © 2019 Kevin Yu. All rights reserved.
//

import UIKit
import CoreData

class GameViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var genreLabel: UITextField!
    @IBOutlet weak var consoleLabel: UITextField!
    
    
    var service: CoreDataService!
    var myGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGame()
    }
    
    func loadGame() {
        if let game = myGame {
            nameLabel.text = game.name
            genreLabel.text = game.genre
            consoleLabel.text = game.console
        }
    }
    
    @IBAction func saveGameButton(_ sender: Any) {
        // get the name, color, size
        // create an object
        // save it in Core Data
        guard let name = nameLabel.text else { return }
        guard let genre = genreLabel.text else { return }
        guard let console = consoleLabel.text else { return }
        
        updateOrCreateGame(name, genre, console)
    }
    
    func updateOrCreateGame(_ name: String, _ genre: String, _ console: String) {
        // get the context
        let context = service.context
        
        // create a Game in the context, if there isn't one
        if myGame == nil {
            myGame = NSEntityDescription.insertNewObject(forEntityName: "Game",
                                                        into: context) as? Game
            /*
             // two-line approach used a lot
             let desc = NSEntityDescription.entity(forEntityName: "Game", in: context)
             myGame = NSManagedObject(entity: desc, insertInto: context)
             */
        }
        myGame.name = name
        myGame.genre = genre
        myGame.console = console
        
        // save (the Game in) the context
        service.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        service.deleteGame(myGame)
        
        nameLabel.text = nil
        genreLabel.text = nil
        consoleLabel.text = nil
        
        
        navigationController?.popViewController(animated: true)
    }
}

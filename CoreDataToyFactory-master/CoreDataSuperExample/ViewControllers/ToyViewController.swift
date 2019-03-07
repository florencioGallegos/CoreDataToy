//
//  ViewController.swift
//  CoreDataSuperExample
//
//  Created by Kevin Yu on 3/5/19.
//  Copyright © 2019 Kevin Yu. All rights reserved.
//

import UIKit
import CoreData

class ToyViewController: UIViewController {

    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var colorLabel: UITextField!
    @IBOutlet var sizeLabel: UITextField!
    
    var service: CoreDataService!
    var myToy: Toy!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadToy()
    }
    
    func loadToy() {
        if let toy = myToy {
            nameLabel.text = toy.name
            colorLabel.text = toy.color
            sizeLabel.text = String(toy.size)
        }
    }

    
    @IBAction func saveButtonAction(_ sender: Any) {
        // get the name, color, size
        // create an object
        // save it in Core Data
        guard let name = nameLabel.text else { return }
        guard let color = colorLabel.text else { return }
        guard let sizeStr = sizeLabel.text, let size = Int16(sizeStr) else { return }
        
        updateOrCreateToy(name, color, size)    }
    
    func updateOrCreateToy(_ name: String, _ color: String, _ size: Int16) {
        // get the context
        let context = service.context
        
        // create a Toy in the context, if there isn't one
        if myToy == nil {
            myToy = NSEntityDescription.insertNewObject(forEntityName: "Toy",
                                                        into: context) as? Toy
            /*
            // two-line approach used a lot
            let desc = NSEntityDescription.entity(forEntityName: "Toy", in: context)
            myToy = NSManagedObject(entity: desc, insertInto: context)
            */
        }
        myToy.name = name
        myToy.color = color
        myToy.size = size
        
        // save (the Toy in) the context
        service.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        service.deleteToy(myToy)
        
        nameLabel.text = nil
        colorLabel.text = nil
        sizeLabel.text = nil
        
        navigationController?.popViewController(animated: true)
    }
}


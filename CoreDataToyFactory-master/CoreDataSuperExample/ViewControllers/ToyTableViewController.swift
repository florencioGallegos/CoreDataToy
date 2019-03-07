//
//  ToyTableViewController.swift
//  CoreDataSuperExample
//
//  Created by Kevin Yu on 3/5/19.
//  Copyright © 2019 Kevin Yu. All rights reserved.
//

import UIKit

class ToyTableViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var toys = [Toy]()
    var games = [Game]()
    var service = CoreDataService()
    var filter = [Toy]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadToys()
        loadGames()
    }
    
    func loadToys() {
        toys = service.loadAllToys()
        tableView.reloadData()
    }
    
    func loadGames() {
        games = service.loadAllGames()
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filter = toys
            tableView.reloadData()
            return
        }
            filter = toys.filter({ toys -> Bool in
            let text = searchBar.text
            }, else { return false})
        tableView.reloadData()
    }
    
  
  
    @IBAction func searchBarButtonAction(_ sender: UIBarButtonItem) {
        toys = service.findAll("Armando")
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gameDetails" {
            let vc = segue.destination as! GameViewController
            vc.myGame = sender as? Game
            vc.service = service
        } else if segue.identifier == "createGame" {
            let vc = segue.destination as! GameViewController
            vc.service = service
        } else if segue.identifier == "toyDetails" {
            let vc = segue.destination as! ToyViewController
            vc.myToy = sender as? Toy
            vc.service = service
        } else if segue.identifier == "createToy" {
            let vc = segue.destination as! ToyViewController
            vc.service = service
        }
    }
}

extension ToyTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        cell.textLabel?.text = toys[indexPath.row].name
        return cell
    }
}

extension ToyTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toyDetails",
                          sender: toys[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            service.deleteToy(toys[indexPath.row])
            loadToys()
        }
    }
}

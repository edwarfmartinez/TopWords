//
//  ViewController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var btnPlayCards: UIButton!
    @IBOutlet weak var btnPlayCompare: UIButton!
    
    var games = [Game]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadGames()
    }
    
    func loadGames() {
        let request : NSFetchRequest<Game> = Game.fetchRequest()
        do{
            games = try context.fetch(request)
        } catch {
            print("Error loading games: \(error)")
        }
        btnPlayCards.setTitle(games[0].name, for: .normal)
        btnPlayCompare.setTitle(games[1].name, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        
        let destVC = segue.destination as! MasterViewController
        destVC.segueName = segue.identifier!
        
        
        
    }
    
    
    
}

//
//  ViewController.swift
//  UIKit_2
//
//  Created by Kamil on 06.07.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    lazy var frc: NSFetchedResultsController<Character> =  {
        let request: NSFetchRequest<Character> = Character.fetchRequest()
        request.sortDescriptors = [.init(key: "id", ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: PersistentContainer.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        print(frc.fetchedObjects?.count ?? 0)
        frc.delegate = self
        
        return frc
    }()
    
    let manager: NetworkManagerProtocol = NetworkManager()
    var characters: [CharacterResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        do {
            try frc.performFetch()
        } catch {
            print(error)
        }
        
        loadCharacters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkForLaunches()
    }
    
    func checkForLaunches() {
        let defaults = UserDefaults.standard
        if var numberOfLaunches = defaults.object(forKey: "numberOfLaunches") as? Int {
            numberOfLaunches += 1
            print(numberOfLaunches)
            defaults.setValue(numberOfLaunches, forKey: "numberOfLaunches")
            
            if numberOfLaunches % 3 == 0 {
                print("It is your \(numberOfLaunches) time of launching this app")
                showAlert(numberOfLaunches: numberOfLaunches)
            }
            
        } else {
            defaults.setValue(1, forKey: "numberOfLaunches")
        }
    }
    
    func showAlert(numberOfLaunches: Int) {
        let alertController = UIAlertController(title: "Hello!", message: "It is your \(numberOfLaunches) launch", preferredStyle: .alert)
        
        let okayButton = UIAlertAction(title: "Done", style: .default) {_ in}
        alertController.addAction(okayButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func loadCharacters() {
        manager.fetchCharacters { result in
            switch result {
            case let .success(response):
                self.characters = response
                if self.frc.fetchedObjects?.count == 0 {
                    self.saveCharacters()
                }
                print("success")
                self.tableView.reloadData()
            case .failure:
                self.characters = []
                print("fail")
            }
        }
    }
    
    func saveCharacters() {
        PersistentContainer.shared.performBackgroundTask { [weak self] backgroundContext in
            guard let self = self else {return}
            for character: CharacterResponseModel in self.characters {
                let newCharacter = Character(context: backgroundContext)
                newCharacter.name = character.name
                newCharacter.gender = character.gender
                newCharacter.location = character.location.name
                newCharacter.species = character.species
                newCharacter.status = character.status
            }
            
            PersistentContainer.shared.saveContext(backgroundContext: backgroundContext)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell
        else {
            return UITableViewCell()
        }
        
        if characters.count == 0 {
            let character = frc.object(at: indexPath)
            characterCell.setUpData(character)
        } else {
            let cellData = characters[indexPath.row]
            characterCell.setUpData(cellData)
        }
        
        return characterCell
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if characters.count == 0 {
            if let sections = frc.sections {
                return sections[section].numberOfObjects
                
            }
        }
        return characters.count
    }

    
}

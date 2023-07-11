//
//  ViewController.swift
//  UIKit_2
//
//  Created by Kamil on 06.07.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
//    var data: [CharacterData] = [
//        CharacterData(id: UUID(), name: "Rick Prime", status: CharacterData.Status.alive, species: "Human", gender: CharacterData.Gender.unknown, location: "Earth", image: #imageLiteral(resourceName: "Rick.png")),
//        CharacterData(id: UUID(), name: "Adam", status: CharacterData.Status.dead, species: "Narnian", gender: CharacterData.Gender.unknown, location: "Narnia Dimension", image:#imageLiteral(resourceName: "Adam.jpg") ),
//        CharacterData(id: UUID(), name: "Japheth", status: CharacterData.Status.dead, species: "Narnian", gender: CharacterData.Gender.unknown, location: "Narnia Dimension", image: #imageLiteral(resourceName: "Japheth.png")),
//        CharacterData(id: UUID(), name: "Jerry Smith Prime", status: CharacterData.Status.dead, species: "Human", gender: CharacterData.Gender.male, location: "Earth", image: #imageLiteral(resourceName: "Jerry.png")),
//        CharacterData(id: UUID(), name: "Beth Smith Prime", status: CharacterData.Status.dead, species: "Human", gender: CharacterData.Gender.female, location: "Cronenberged Dimension", image: #imageLiteral(resourceName: "Beth.png")),
//        CharacterData(id: UUID(), name: "Naruto Smith", status: CharacterData.Status.alive, species: "Genetically modified human", gender: CharacterData.Gender.male, location: "Earth", image: #imageLiteral(resourceName: "Naruto.png"))
//    ]
    
    let manager: NetworkManagerProtocol = NetworkManager()
    var characters: [CharacterResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        loadCharacters()
    }
    
    func loadCharacters() {
        manager.fetchCharacters { result in
            switch result{
            case let .success(response):
                self.characters = response
                print("success")
                self.tableView.reloadData()
            case .failure:
                self.characters = []
                print("fail")
            }
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
        
        let cellData = characters[indexPath.row]
        
        characterCell.setUpData(cellData)
        
        return characterCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

}

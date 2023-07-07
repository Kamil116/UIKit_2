//
//  ViewController.swift
//  UIKit_2
//
//  Created by Kamil on 06.07.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var data: [CharacterData] = [
        CharacterData(id: UUID(), name: "Rick Prime", status: CharacterData.Status.alive, species: "Human", gender: CharacterData.Gender.unknown, location: "Earth", image: #imageLiteral(resourceName: "Rick.png")),
        CharacterData(id: UUID(), name: "Adam", status: CharacterData.Status.dead, species: "Narnian", gender: CharacterData.Gender.unknown, location: "Narnia Dimension", image:#imageLiteral(resourceName: "Adam.jpg") ),
        CharacterData(id: UUID(), name: "Japheth", status: CharacterData.Status.dead, species: "Narnian", gender: CharacterData.Gender.unknown, location: "Narnia Dimension", image: #imageLiteral(resourceName: "Japheth.png")),
        CharacterData(id: UUID(), name: "Jerry Smith Prime", status: CharacterData.Status.dead, species: "Human", gender: CharacterData.Gender.male, location: "Earth", image: #imageLiteral(resourceName: "Jerry.png")),
        CharacterData(id: UUID(), name: "Beth Smith Prime", status: CharacterData.Status.dead, species: "Human", gender: CharacterData.Gender.female, location: "Cronenberged Dimension", image: #imageLiteral(resourceName: "Beth.png")),
        CharacterData(id: UUID(), name: "Naruto Smith", status: CharacterData.Status.alive, species: "Genetically modified human", gender: CharacterData.Gender.male, location: "Earth", image: #imageLiteral(resourceName: "Naruto.png"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailViewController = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
        else {
            return
        }
        
        detailViewController.delegate = self
        
        present(detailViewController, animated: true)
        
        detailViewController.data = data[indexPath.row]

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell
        else {
            return UITableViewCell()
        }
        
        let cellData = data[indexPath.row]
        
        characterCell.setUpData(cellData)
        
        return characterCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

}

extension ViewController: DetailViewControllgerDelegate {
    func editCharacterData(with id: UUID, name: String) {
        if let index = data.firstIndex(where: { $0.id == id }) {
            data[index].name = name
            tableView.reloadData()
        }
    }
    
    func editCharacterData(with id: UUID, species: String) {
        if let index = data.firstIndex(where: { $0.id == id }) {
            data[index].species = species
            tableView.reloadData()
        }
    }
    
    func editCharacterData(with id: UUID, location: String) {
        if let index = data.firstIndex(where: { $0.id == id }) {
            data[index].location = location
            tableView.reloadData()
        }
    }
}

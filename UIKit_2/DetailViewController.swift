//
//  DetailViewController.swift
//  UIKit_2
//
//  Created by Kamil on 07.07.2023.
//

import UIKit

protocol DetailViewControllgerDelegate: AnyObject {
    func editCharacterData(with id: UUID, name: String)
    func editCharacterData(with id: UUID, species: String)
    func editCharacterData(with id: UUID, location: String)
}

final class DetailViewController: UIViewController {
    
    var data: CharacterData? {
        didSet {
            if data != nil{
                setUpData(data!)
            }
            else {
                return
            }
        }
    }
    
    weak var delegate: DetailViewControllgerDelegate?
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changeNameButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var changeSpeciesButton: UIButton!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var changeLocationButton: UIButton!
    
    
    @IBAction func editNameButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Enter new value", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default) { [self]
            (action) in
            let text = alertController.textFields?.first
            self.nameLabel.text! = "Name: " + (text?.text!)!
            if self.data != nil {
                delegate?.editCharacterData(with: data!.id, name: (text?.text!)!)
            }
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        alertController.addAction(action)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editSpeciesButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Enter new value", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default) { [self]
            (action) in
            let text = alertController.textFields?.first
            self.speciesLabel.text! = "Species: " + (text?.text!)!
            if self.data != nil {
                delegate?.editCharacterData(with: data!.id, species: (text?.text!)!)
            }
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Species"
        }
        alertController.addAction(action)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func editLocationButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Enter new value", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default) { [self]
            (action) in
            let text = alertController.textFields?.first
            self.locationLabel.text! = "Location: " + (text?.text!)!
            if self.data != nil {
                delegate?.editCharacterData(with: data!.id, location: (text?.text!)!)
            }
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Location"
        }
        alertController.addAction(action)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setUpData(_ data: CharacterData) {
        characterImageView.image = data.image
        nameLabel.text = "Name: " + data.name
        statusLabel.text = "Status: "
        switch data.status {
        case CharacterData.Status.alive:
            statusLabel.text! += "alive"
        case CharacterData.Status.dead:
            statusLabel.text! += "dead"
        case CharacterData.Status.unknown:
            statusLabel.text! += "unknown"
        }
        speciesLabel.text = "Species: " + data.species
        genderLabel.text = "Gender: "
        switch data.gender {
        case CharacterData.Gender.male:
            genderLabel.text! += "male"
        case CharacterData.Gender.female:
            genderLabel.text! += "female"
        case CharacterData.Gender.genderless:
            genderLabel.text! += "genderless"
        case CharacterData.Gender.unknown:
            genderLabel.text! += "unknown"
        }
        locationLabel.text = "Location: " + data.location
    }
}

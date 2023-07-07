//
//  CharacterTableViewCell.swift
//  UIKit_2
//
//  Created by Kamil on 06.07.2023.
//

struct CharacterData {
    enum Status {
        case alive
        case dead
        case unknown
    }
    
    enum Gender {
        case female
        case male
        case genderless
        case unknown
    }
    
    let id: UUID
    var name: String
    let status: Status
    var species: String
    let gender: Gender
    var location: String
    let image: UIImage
}

import UIKit

final class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        locationLabel.text = "Location: " + 	data.location
    }
}

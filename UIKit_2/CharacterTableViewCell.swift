//
//  CharacterTableViewCell.swift
//  UIKit_2
//
//  Created by Kamil on 06.07.2023.
//

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
    
    func setUpData(_ data: CharacterResponseModel) {
        nameLabel.text = "Name: " + data.name
        statusLabel.text = "Status: " + data.status
        speciesLabel.text = "Species: " + data.species
        genderLabel.text = "Gender: " + data.gender
        locationLabel.text = "Location: " + data.location.name
    }
    
    func setUpData(_ data: Character) {
        nameLabel.text = "Name: " + data.name!
        statusLabel.text = "Status: " + data.status!
        speciesLabel.text = "Species: " + data.species!
        genderLabel.text = "Gender: " + data.gender!
        locationLabel.text = "Location: " + data.location!
    }
}

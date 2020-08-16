//
//  TableViewCell.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var secondaryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.font = secondaryLabel.font
            .withSize(secondaryLabel.font.pointSize - Appearance.Settings.fontSizeDifference)
        secondaryLabel.textColor = detailTextLabel?.textColor ?? .secondaryLabel
        addSubview(secondaryLabel)
        
        if let textLabel = textLabel {
            secondaryLabel.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: Appearance.Settings.tableViewCellspacing)
                .isActive = true
        }
        secondaryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        accessoryType = .none
        textLabel?.text = ""
        secondaryLabel.text = ""
    }
}

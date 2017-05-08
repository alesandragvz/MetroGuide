//
//  StationTableViewCell.swift
//  MetroGuide
//
//  Created by Alexandra on 5/8/17.
//  Copyright © 2017 Alexandra. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    var station: Station! {
        didSet {
            switch station.color {
            case .blue:
                colorIndicator.backgroundColor = .blue
            case .red:
                colorIndicator.backgroundColor = .red
            case .green:
                colorIndicator.backgroundColor = .green
            }
            titleLabel.text = station.title
        }
    }

    @IBOutlet weak var colorIndicator: UIView!
    @IBOutlet weak var titleLabel: UILabel!


}

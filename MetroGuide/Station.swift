//
//  Station.swift
//  MetroGuide
//
//  Created by Alexandra on 5/8/17.
//  Copyright © 2017 Alexandra. All rights reserved.
//

import Foundation

enum StationColor {
    case red
    case green
    case blue
}

class Station: Equatable {
    let title: String
    let color: StationColor
    weak var transferStation: Station?
    
    init(title: String,
         color: StationColor, 
         transferStation: Station? = nil) {
        self.title = title
        self.color = color
        self.transferStation = transferStation
    }
    
    func hasTransferToStation(withColor color: StationColor) -> Bool {
        guard let transferStation = transferStation else {
            return false
        }
        return transferStation.color == color
    }
    
    static func == (lhs: Station, rhs: Station) -> Bool {
        return lhs.title == rhs.title &&
            lhs.color == rhs.color
    }
}

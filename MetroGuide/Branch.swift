//
//  File.swift
//  MetroGuide
//
//  Created by Alexandra on 5/8/17.
//  Copyright © 2017 Alexandra. All rights reserved.
//

import Foundation

class Branch {
    let stations: [Station]
    
    init(stations: [Station]) {
        self.stations = stations
    }
    
    func getRoute(between start: Station, and end: Station) -> [Station] {
        guard let startIndex = stations.index(of: start),
            let endIndex = stations.index(of: end) else {
                return []
        }
        if startIndex > endIndex {
            return [Station](stations[endIndex...startIndex]).reversed()
        }
        return [Station](stations[startIndex...endIndex])
    }
}

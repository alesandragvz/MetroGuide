//
//  RouteBuilder.swift
//  MetroGuide
//
//  Created by Alexandra on 5/8/17.
//  Copyright © 2017 Alexandra. All rights reserved.
//

import Foundation

class RouteBuilder {
    let branches: [Branch]
    
    init() {
        let s1 = Station(title: "Хрещатик", color: .red)
        let s2 = Station(title: "Майдан Незалежності", color: .blue)
        let s3 = Station(title: "Театральна", color: .red)
        let s4 = Station(title: "Площа Льва Толстого", color: .blue)
        let s5 = Station(title: "Золоті Ворота", color: .green)
        let s6 = Station(title: "Палац спорту", color: .green)
        
        s1.transferStation = s2
        s2.transferStation = s1
        
        s3.transferStation = s5
        s5.transferStation = s3
        
        s4.transferStation = s6
        s6.transferStation = s4
        
        let redBranchStations = [Station(title: "Академмістечко", color: .red),
                                 Station(title: "Житомирська", color: .red),
                                 Station(title: "Святошин", color: .red),
                                 Station(title: "Нивки", color: .red),
                                 Station(title: "Берестейська", color: .red),
                                 Station(title: "Шулявська", color: .red),
                                 Station(title: "Політехнічний інститут", color: .red),
                                 Station(title: "Вокзальна", color: .red),
                                 Station(title: "Університет", color: .red),
                                 s3,
                                 s1,
                                 Station(title: "Арсенальна", color: .red),
                                 Station(title: "Дніпро", color: .red),
                                 Station(title: "Гідропарк", color: .red),
                                 Station(title: "Лівобережна", color: .red),
                                 Station(title: "Дарниця", color: .red),
                                 Station(title: "Чернігівська", color: .red),
                                 Station(title: "Лісова", color: .red)]
        
        let greenBranchStations = [Station(title: "Сирець", color: .green),
                                Station(title: "Дорогожичі", color: .green),
                                Station(title: "Лукьянівська", color: .green),
                                s5,
                                s6,
                                Station(title: "Кловська", color: .green),
                                Station(title: "Печерська", color: .green),
                                Station(title: "Дружби народів", color: .green),
                                Station(title: "Видубичі", color: .green),
                                Station(title: "Славутич", color: .green),
                                Station(title: "Осокорки", color: .green),
                                Station(title: "Позняки", color: .green),
                                Station(title: "Харківська", color: .green),
                                Station(title: "Вирлиця", color: .green),
                                Station(title: "Бориспільська", color: .green),
                                Station(title: "Червоний хутір", color: .green)]
        
        let blueBranchStations = [Station(title: "Героїв дніпра", color: .blue),
                                 Station(title: "Мінська", color: .blue),
                                 Station(title: "Оболонь", color: .blue),
                                 Station(title: "Петрівка", color: .blue),
                                 Station(title: "Тараса Шевченка", color: .blue),
                                 Station(title: "Контрактова площа", color: .blue),
                                 Station(title: "Поштова площа", color: .blue),
                                 s2,
                                 s4,
                                 Station(title: "Олімпійська", color: .blue),
                                 Station(title: "Палац Україна", color: .blue),
                                 Station(title: "Либідська", color: .blue),
                                 Station(title: "Деміївська", color: .blue),
                                 Station(title: "Голосіївська", color: .blue),
                                 Station(title: "Васильківська", color: .blue),
                                 Station(title: "Виставковий центр", color: .blue),
                                 Station(title: "Іподром", color: .blue),
                                 Station(title: "Теремки", color: .blue)]
        
        self.branches = [Branch(stations: redBranchStations),
                         Branch(stations: greenBranchStations),
                         Branch(stations: blueBranchStations)]
    }
    
    func buildRoute(between startStation: Station, and endStation: Station) -> [Station] {
        if startStation.color == endStation.color {
            return branches[branches.index(where: { $0.stations[0].color == startStation.color })!].getRoute(between: startStation, and: endStation)
        }
        
        var route = [Station]()
        
        let startBranch = branches[branches.index(where: { $0.stations[0].color == startStation.color })!]
        let endBranch = branches[branches.index(where: { $0.stations[0].color == endStation.color })!]
        
        let startBranchTransferStationIndex = startBranch.stations.index(where: {
            guard let transferStation = $0.transferStation else {
                return false
            }
            return transferStation.color == endStation.color
        })!
        let startBranchTransferStation = startBranch.stations[startBranchTransferStationIndex]
        let endBranchTransferStation = endBranch.stations[endBranch.stations.index(of: startBranchTransferStation.transferStation!)!]
        
        route.append(contentsOf: startBranch.getRoute(between: startStation, and: startBranchTransferStation))
        route.append(contentsOf: endBranch.getRoute(between: endBranchTransferStation, and: endStation))
        
        return route
    }
}

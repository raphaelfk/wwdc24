//
//  GameManager.swift
//  Robbo’s Adventure
//
//  Created by Raphael Ferezin Kitahara on 18/01/24.
//

import Foundation
import SwiftUI

class GameManager: ObservableObject {
    @Published var allLevelsComplete = false
    @Published var firstLevelComplete = false
    @Published var playingFirstLevel = false
    @Published var playingSecondLevel = false
    @Published var playingThirdLevel = false
    @Published var secondLevelAvailable = false
    @Published var secondLevelComplete = false
    @Published var thirdLevelAvailable = false
    
    
    // Mission control terminal variables
    @Published var animateFirstLevelMessage = true
    @Published var animateSecondLevelMessage = true
    
    let firstLevelMissionControlMessage = "Start with the first mission.\nOnce you complete it, others will become available!"
    let secondLevelMissionControlMessage = "Ribbo is now on the Castle Planet.\nIt needs your help again in his second mission!"
}

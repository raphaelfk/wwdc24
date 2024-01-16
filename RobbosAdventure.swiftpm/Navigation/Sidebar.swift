//
//  Sidebar.swift
//  My App
//
//  Created by Raphael Ferezin Kitahara on 15/01/24.
//

import SwiftUI

enum Panel: Hashable {
    /// The value for the ``CoursesView``.
    case courses
    /// The value for the ``LevelOneView``.
    case levelOne
    /// The value for the ``LevelTwoView``.
    case levelTwo
    /// The value for the ``LevelThreeView``.
    case levelThree
    /// The value for the ``LevelFourView``.
    case levelFour
    /// The value for the ``LevelFiveView``.
    case levelFive
    /// The value for the ``LevelSixView``.
    case levelSix

}

struct SidebarView: View {
    @State var selection: Panel = .courses
    
    var body: some View {
        List{
            NavigationLink(destination: CoursesView()) {
                Label("Courses Board", systemImage: "text.book.closed")
            }
            
            Section("The Basics") {
                NavigationLink(destination: FirstLevelView()) {
                    Label("Commands", systemImage: "command")
                }
            }
            
            
            
        }
        .navigationTitle("Robbo's Adventure")
    }
}

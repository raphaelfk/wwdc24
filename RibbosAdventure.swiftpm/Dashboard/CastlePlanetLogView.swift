//
//  CastlePlanetLogView.swift
//
//
//  Created by Raphael Ferezin Kitahara on 20/02/24.
//

import SwiftUI

struct CastlePlanetLogView: View {
    @Environment (\.colorScheme) var colorScheme
    @Binding var sheetVisibility: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // header
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Mission Log")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                    
                    Text("Castle Planet")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("blue"))
                }
                
                Spacer()
                
                Button(action: {
                    sheetVisibility = false
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.gray.opacity(0.25))
                })
                .buttonStyle(.plain)
                
            }
            .padding(.bottom)
            
            
            
            // description
            
            Text("Castle planet was a rough mission for Ribbo, mainly because of all of the fog, caused by the planet's humidity and high temperatures.")
            
            Text("Some of the planet's highlights were lava formations and the amazing castle structures that were built by ancient civilizations.")
            
            Text("The castles are kept by the local communities nowadays, which shed light about how important it is for them to preserve their culture and history.")
            
            // image
            HStack {
                Spacer()
                
                Image(colorScheme == .light ? "castlePlanetSketchLight" : "castlePlanetSketchDark")
                    .resizable()
                    .scaledToFit()
            }
            
            
            
            Spacer()
            
            // page watermarks
            HStack(alignment: .bottom) {
                Image("rsc-watermark")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                
                Spacer()
                
                Image("starBorder")
                
            }
        }
        .padding(32)
    }
}

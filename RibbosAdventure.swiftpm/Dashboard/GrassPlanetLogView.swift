//
//  GrassPlanetLogView.swift
//
//
//  Created by Raphael Ferezin Kitahara on 26/01/24.
//

import SwiftUI

struct GrassPlanetLogView: View {
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
                    
                    Text("Grass Planet")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("green"))
                }
                
                Spacer()
                
                Button(action: {
                    sheetVisibility = false
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.gray.opacity(0.15))
                })
                .buttonStyle(.plain)
                
            }
            .padding(.bottom)
            
            
            
            // description
  
            Text("Throughout its explorations of Grass Planet, Ribbo collected samples of the planet's most abundant natural formation: Grass.")
            
            Text("This planet's highlights were it's natural formations, such as rocks, rivers and mountains, which composed the landscape in most places.")

            Text("The citizens of Grass Planet are known for their sustainability efforts and for how they use technology to enforce nature preservation.")
            
            // image
            HStack {
                Spacer()
                
                Image(colorScheme == .light ? "grassPlanetSketchLight" : "grassPlanetSketchDark")
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

struct GrassPlanetLogViewPreview: View {
    @State var sheetVisibility = true
    var body: some View {
        GrassPlanetLogView(sheetVisibility: $sheetVisibility)
    }
}

#Preview {
    GrassPlanetLogViewPreview()
}

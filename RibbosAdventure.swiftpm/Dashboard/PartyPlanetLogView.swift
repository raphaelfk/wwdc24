//
//  SwiftUIView.swift
//  
//
//  Created by Raphael Ferezin Kitahara on 21/02/24.
//

import SwiftUI

struct PartyPlanetLogView: View {
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
                    
                    Text("Party Planet")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("purple"))
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
            
            Text("Party Planet presented one of the toughest challenges Ribbo had to go through, but it reminded us that sometimes you just have to dance it away.")
            
            Text("The citizens of Party Planet reminded our team that after hard work some partying is always deserved!")
            
            Text("RCS thanks you for all of the help provided, and we hope that you take some of the lessons learned in this journey with you!")
            
            // image
            HStack {
                Spacer()
                
                Image(colorScheme == .light ? "partyPlanetSketchLight" : "partyPlanetSketchDark")
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


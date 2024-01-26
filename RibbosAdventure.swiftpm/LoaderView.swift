//
//  LoaderView.swift
//  Ribbo’s Adventure
//
//  Created by Raphael Ferezin Kitahara on 25/01/24.
//

import SwiftUI

struct LoaderView: View {
    @State var isRotated = false
    
    var body: some View {
        ZStack(alignment: .center) {
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.03, green: 0.05, blue: 0.22), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.02, green: 0.03, blue: 0.14), location: 0.50),
                    Gradient.Stop(color: Color(red: 0.01, green: 0.04, blue: 0.16), location: 1.00),
                ],
                startPoint: UnitPoint(x: 1, y: 0),
                endPoint: UnitPoint(x: 0, y: 1)
            )
            .ignoresSafeArea()
            
            Image("onboardingStars1")
                .resizable()
                .scaledToFit()
            
            Image("onboardingStars2")
                .resizable()
                .scaledToFit()
            
            Image("rocket-loader")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.75).repeatForever(autoreverses: false)) {
                        isRotated.toggle()
                    }
                }
        }
    }
}

#Preview {
    LoaderView()
}

//
//  NumberPadView.swift
//  Ribbo’s Adventure
//
//  Created by Raphael Ferezin Kitahara on 24/01/24.
//

import SwiftUI

struct NumberPadView: View {
    let blockID: UUID
    @Binding var codeBlocksList: [CodeBlock]
    
    var body: some View {
        VStack {
            HStack {
                let numbers1to3 = ["1", "2", "3"]
                ForEach(numbers1to3, id: \.self) { number in
                    Text(number)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(hex: "FF79B3").opacity(0.75))
                        }
                        .padding(6)
                        .onTapGesture {
                            var listIndex = 0
                            for codeBlock in self.codeBlocksList {
                                if codeBlock.id == blockID {
                                    codeBlocksList[listIndex].command = number
                                    break
                                }
                                
                                listIndex += 1
                            }
                        }
                }
            }
            
            HStack {
                let numbers1to3 = ["4", "5", "6"]
                ForEach(numbers1to3, id: \.self) { number in
                    Text(number)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(hex: "FF79B3").opacity(0.75))
                        }
                        .padding(6)
                        .onTapGesture {
                            var listIndex = 0
                            for codeBlock in self.codeBlocksList {
                                if codeBlock.id == blockID {
                                    codeBlocksList[listIndex].command = number
                                    break
                                }
                                
                                listIndex += 1
                            }
                        }
                }
            }
            
            HStack {
                let numbers1to3 = ["7", "8", "9"]
                ForEach(numbers1to3, id: \.self) { number in
                    Text(number)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(hex: "FF79B3").opacity(0.75))
                        }
                        .padding(6)
                        .onTapGesture {
                            var listIndex = 0
                            for codeBlock in self.codeBlocksList {
                                if codeBlock.id == blockID {
                                    codeBlocksList[listIndex].command = number
                                    break
                                }
                                
                                listIndex += 1
                            }
                        }
                }
            }
        }
    }
}

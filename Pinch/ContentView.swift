//
//  ContentView.swift
//  Pinch
//
//  Created by 이찬영 on 2023/06/13.
//

import SwiftUI

struct ContentView: View {
    
    @State private var launchAnimation : Bool = false
    @State private var imageScale : CGFloat = 1
    @State private var imageOffset : CGSize = .zero
    
    func resetImage() {
        withAnimation(.linear(duration: 1)) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {
        
        NavigationStack {
                
                ZStack {
                    
                    Color.clear
                    
                    Image("magazine-front-cover")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding()
                        .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                        .opacity(launchAnimation ? 1 : 0)
                        .offset(imageOffset)
                        .scaleEffect(imageScale)
                        .gesture(DragGesture(coordinateSpace: .global)
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            })
                                .onEnded({ _ in
                                    if imageScale <= 1 {
                                       resetImage()
                                    }
                                })
                        
                        )
                        .onTapGesture(count: 2, perform: {
                            withAnimation(.spring()) {
                                if imageScale == 1 {
                                    imageScale = 5
                                } else {
                                    resetImage()
                                }
                            }
                        })
                }
                .onAppear {
                    withAnimation(.linear(duration: 1.0)) {
                        launchAnimation = true
                    }
                }
                .overlay(alignment : .top) {
                    TopView(scale: imageScale, offset: imageOffset)
                        .padding(.horizontal)
                        .padding(.top, 30)
                }
                .overlay(alignment : .bottom) {
                    BottomPanelView(imageScale: $imageScale, imageOffset: $imageOffset)
                        .padding(.bottom, 30)
                }
                .navigationTitle("Pinch & Zoom")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

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
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(launchAnimation ? 1 : 0)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        withAnimation(.spring()) {
                            if imageScale == 1 {
                                imageScale = 5
                            } else {
                                imageScale = 1
                            }
                        }
                    })
            }
            .onAppear {
                withAnimation(.linear(duration: 1.0)) {
                    launchAnimation = true
                }
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

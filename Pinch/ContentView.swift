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
    @State private var isThumbnailOpen : Bool = false
    @State private var switchImage : Bool = false
    
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
                    
                    Image(switchImage ? "magazine-back-cover" : "magazine-front-cover")
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
                        .overlay(alignment : .topTrailing) {
                            if isThumbnailOpen {
                                HStack {
                                        Image(systemName:"chevron.compact.right")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(EdgeInsets(top: 26, leading: 8, bottom: 26, trailing: 8))
                                            .foregroundColor(.secondary)
                                            .onTapGesture {
                                                withAnimation(.spring()) {
                                                    isThumbnailOpen.toggle()
                                                }
                                            }
                                        
                                    Spacer()
                                        
                                    Button {
                                        
                                        withAnimation(.linear(duration: 1)) {
                                            switchImage = false
                                        }
                                    
                                    } label: {
                                        Image("thumb-magazine-front-cover")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .cornerRadius(8)
                                    }

                                        
                                    Spacer()
                                        
                                    Button {
                                        
                                        withAnimation(.linear(duration: 1)) {
                                            switchImage = true
                                        }
                                        
                                    } label: {
                                        Image("thumb-magazine-back-cover")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .cornerRadius(8)
                                    }

                                        
                                    Spacer()
                                        
                                    }
                                    .padding(8)
                                    .frame(width: 240, height: UIScreen.main.bounds.height / 7)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(8)
                                
                            } else {
                                
                                HStack {
                                    Image(systemName:"chevron.compact.left")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 12, trailing: 8))
                                        .foregroundColor(.secondary)
                                        .onTapGesture {
                                            withAnimation(.spring()) {
                                                isThumbnailOpen.toggle()
                                            }
                                    }
                                }
                                .padding(8)
                                .frame(width: 45, height: UIScreen.main.bounds.height / 7)
                                .background(.ultraThinMaterial)
                                .cornerRadius(8)
                                
                            }
                        }
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

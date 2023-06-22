//
//  BottomPanelView.swift
//  Pinch
//
//  Created by 이찬영 on 2023/06/22.
//

import SwiftUI

struct BottomPanelView: View {
    
    @Binding var imageScale : CGFloat
    @Binding var imageOffset : CGSize
    
    var body: some View {
        
        HStack {
            
            Button {
                withAnimation(.spring()) {
                    
                    if imageScale <= 5 && 1 < imageScale {
                        imageScale -= 1
                    }
                    
                    if imageScale == 1 {
                        imageOffset = .zero
                    }
                }

            } label: {
                Image(systemName: "minus.magnifyingglass")
            }

            Spacer()
            
            Button {
                
                withAnimation(.spring()) {
                    if imageScale == 5 || imageScale > 1 {
                        imageScale = 1
                        imageOffset = .zero
                    } else if imageScale == 1 || imageScale < 5 {
                        imageScale = 5
                    }
                }
                
            } label: {
                Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
            }

            Spacer()
            
            Button {
                
                withAnimation(.spring()) {
                    if imageScale <= 4 && 0 < imageScale {
                        imageScale += 1
                    }
                }
                
            } label: {
                Image(systemName: "plus.magnifyingglass")
            }

        }
        .font(.largeTitle)
        .frame(width: 120, height: 30)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

struct BottomPanelView_Previews: PreviewProvider {
    static var previews: some View {
        BottomPanelView(imageScale: .constant(1), imageOffset: .constant(.zero))
    }
}

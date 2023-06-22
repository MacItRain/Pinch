//
//  TopView.swift
//  Pinch
//
//  Created by 이찬영 on 2023/06/22.
//

import SwiftUI

struct TopView: View {
    
    var scale : CGFloat
    var offset : CGSize
    @State private var infoPanelVisible : Bool = false
    
    var body: some View {
        
        HStack(spacing: 2) {
            
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1.0) {
                    withAnimation(.easeInOut) {
                        infoPanelVisible.toggle()
                    }
                }
            
            Spacer()
            
            HStack {
                
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")

                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")

                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
            }
            .opacity(infoPanelVisible ? 1 : 0)
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            
            Spacer()
            
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView(scale: 1, offset: .zero)
    }
}

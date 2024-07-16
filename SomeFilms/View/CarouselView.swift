//
//  CarouselView.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 10.07.2024.
//

import Foundation
import SwiftUI

struct CarouselView: View {
    @State var currentDoc: [Doc]
    @State private var currentImages: [(UIImage?, Bool)] = [(nil, false), (nil, false), (nil, false), (nil, false), (nil, false)]
 
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            
            Color.gray24
            
            if currentIndex < currentDoc.count {
                if let image = currentImages[currentIndex].0 {
                    if currentImages[currentIndex].1 {
                        openDetail(currentDoc[currentIndex], someView:
                                    Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .clipped()
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                            .animation(.easeInOut)
                        )
                        .highPriorityGesture(
                            DragGesture()
                                .onEnded { value in
                                    if value.translation.width > 50 {
                                        currentIndex = max(0, currentIndex - 1)
                                    } else if value.translation.width < -50 {
                                        currentIndex = min(4, currentIndex + 1)
                                        
                                    }
                                }
                        )
                    } else {
                        openDetail(currentDoc[currentIndex], someView:
                                    Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .clipped()
                            .animation(.easeInOut)
                        )
                        .highPriorityGesture(
                            DragGesture()
                                .onEnded { value in
                                    if value.translation.width > 50 {
                                        currentIndex = max(0, currentIndex - 1)
                                    } else if value.translation.width < -50 {
                                        currentIndex = min(4, currentIndex + 1)
                                        
                                    }
                                }
                        )
                    }
                }
            }
                                           
            
            
            VStack {
                Spacer()
                HStack {
                    ForEach(0..<5, id: \.self) { index in
                        Circle()
                            .fill(currentIndex == index ? Color.blue : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(16)
            }
        } .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        .frame(width: 400, height: 200)
        .gesture(
            DragGesture()
               
                .onChanged { value in
                    
                }
                .onEnded { value in
                    if value.translation.width > 50 {
                        currentIndex = max(0, currentIndex - 1)
                    } else if value.translation.width < -50 {
                        currentIndex = min(4, currentIndex + 1)
                    }
                }
        )
        .onAppear {
            Task {
                
                currentDoc = await deleteWithoutImageFromDoc(doc: currentDoc)
                
                if currentDoc.count > 0 {
                    for index in 0..<5 {
                        let doc = currentDoc[index]
                        if let url = doc.logo?.url {
                            APIManager().loadImage(urlString: url) { image in
                                currentImages[index].0 = image
                                currentImages[index].1 = true
                            }
                        } else {
                            if let url = doc.poster?.url {
                                APIManager().loadImage(urlString: url) { image in
                                    currentImages[index].0 = image
                                    currentImages[index].1 = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(currentDoc: testMain)
    }
}

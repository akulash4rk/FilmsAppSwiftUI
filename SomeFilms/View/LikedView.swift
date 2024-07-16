//
//  LikedView.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 15.07.2024.
//

import Foundation
import SwiftUI


struct LikedView: View {
    
    @State var currentDoc: [Doc] = []
    @State private var images : [UIImage?]? = nil
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color.gray1C
                    VStack(spacing: 16) {
                        if let images = images {
                            
                            ForEach(0..<currentDoc.count, id: \.self) {index in
                                openDetail(currentDoc[index], someView:
                                            HStack{
                                    if let currentImage = images[index] {
                                        Image(uiImage: currentImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .clipped()
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                                            .animation(.easeInOut)
                                    }
                                    VStack {
                                        
                                        if let name = currentDoc[index].name {
                                            HStack {
                                                Text(name).mainFont()
                                                Spacer()
                                            }
                                        }
                                        if let desc = currentDoc[index].shortDescription {
                                            Text(desc)
                                                .font(.custom("OpenSans-Regular", size: 20))
                                                .foregroundColor(Color.grayDE)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .lineLimit(4)
                                                .multilineTextAlignment(.leading)
                                        } else if let desc = currentDoc[index].description{
                                            
                                            Text(desc)
                                                .font(.custom("OpenSans-Regular", size: 20))
                                                .foregroundColor(Color.grayDE)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .lineLimit(4)
                                            
                                        }
                                    }
                                })
                            } .frame(height: 150)
                        }
                    }
                }
            } .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .background(Color.gray1C)
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.black1C)
        .toolbar(.visible, for: .tabBar)
        .background(Color.gray1C)
        
        .onAppear(){
            
            currentDoc = Array(savedFilms.values)
            
            images = Array(repeating: nil, count: currentDoc.count)
            
            
            for index in 0..<min(images!.count, currentDoc.count)  {
                
                let doc = currentDoc[index]
                
                if let url = doc.poster?.url {
                    APIManager().loadImage(urlString: url) { image in
                        if let currentImages = images, index < currentImages.count  {
                            images![index] = image
                        }
                    }
                } else {
                    if let url = doc.logo?.url {
                        APIManager().loadImage(urlString: url) { image in
                            if let currentImages = images, index < currentImages.count  {
                            images![index] = image
                            }
                        }
                    }
                }
            }
            
        }
    }
}





#Preview {
    LikedView(currentDoc: testMain)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

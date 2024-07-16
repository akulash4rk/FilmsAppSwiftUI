//
//  mainScrollView.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 10.07.2024.
//

import Foundation
import SwiftUI

struct MainScrollView: View {
    
    @State var docs: [Doc]?
    let name: String
    @State private var showDetailView = false
    @State private var currentImages: [UIImage?] = [nil, nil, nil, nil, nil]
    
    var body: some View {
        
        VStack {
            HStack {
                Text(name).mainFont()
                    .font(.title3)
                    .foregroundStyle(Color.grayDE)
                    .padding(.leading, 16)
                Spacer()
                if let docs = docs {
                    
                    NavigationLink {
                        FullView(currentDoc: docs)
                    } label: {
                        Text("Просмотреть все")
                            .font(.caption2)
                            .foregroundStyle(Color.gray77)
                        
                        Image(systemName: "arrow.right")
                            .foregroundStyle(Color.gray77)
                    }
                    .padding(.trailing, 16)

                    
//                    NavigationLink(destination:
//                        FullView(currentDoc: docs),
//                    label: {
//                        Text("Просмотреть все")
//                            .font(.caption2)
//                            .foregroundStyle(Color.gray77)
//                        
//                        Image(systemName: "arrow.right")
//                            .foregroundStyle(Color.gray77)
//                    }
//                    .padding(.trailing, 16)
                }
            }
            .padding(0)
            
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 16) {
                    if let docs = docs {
                        ForEach(0..<min(5, docs.count), id: \.self) { index in
                            if let image = currentImages[index] {
                                
                                openDetail(docs[index], someView: Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 200)
                                    .cornerRadius(12)
                                    .clipped()
                                )
                            }
                        }
                    }
                }
                .padding(.leading, 16)
            }
        } .onAppear() {
            Task{
                
                if let some = docs {
                    
                    docs = deleteWithoutImageFromDoc(doc: some)
                    
                    for index in 0..<min(currentImages.count, docs!.count)  {
                        
                        let doc = docs![index]
         
                        if doc.isFake == true, let id = doc.id {
                            APIManager().getByID(id: id) {data in
                                if let data {
                                    docs![index] = data
                                }
                            }
                        }
                        
                        if let url = doc.poster?.url {
                            APIManager().loadImage(urlString: url) { image in
                                currentImages[index] = image
                            }
                        } else {
                            if let url = doc.logo?.url {
                                APIManager().loadImage(urlString: url) { image in
                                    currentImages[index] = image
                                }
                            }
                        }
                    }
                }

            }
        }
    }
}

struct MainScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MainScrollView(docs: simToDoc(testMain[0]), name: "Pop")
    }
}

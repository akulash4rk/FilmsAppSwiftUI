//
//  SerialDetails.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 11.07.2024.
//

import Foundation
import SwiftUI


struct SerialDetails: View {
    
    let currentDoc : Doc
    @State private var mainImage : UIImage? = nil
    @State private var secondImage : UIImage? = nil
    @State private var saved: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack() {
                    if let mainImage {
                        Image(uiImage: mainImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(alignment: .top)
                            .clipped()
                        
                        
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, Color.gray1C]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                    if let secondImage {
                        VStack{
                            Spacer()
                            HStack {
                                Spacer()
                                Image(uiImage: secondImage)
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 180, height: 212)
                                    .clipped()
                                    .cornerRadius(12)
                                
                                Spacer()
                            }
                        }
                    }
                }
                if let name = currentDoc.name {
                    Text(name).mainFont()
                }
                
                
                if let genres = currentDoc.genres {
                    HStack {
                        ForEach(0..<min(genres.count, 2)) {count in
                            if let currentGeneres = genres[count].name {
                                Circle()
                                    .frame(width: 6, height: 6)
                                    .foregroundColor(Color.gray77)
                                Text(currentGeneres)
                                    .font(.custom("OpenSans-Regular", size: 20))
                                    .foregroundColor(Color.grayDE)
                            }
                        }
                    }
                }
                HStack {
                    if let kp = currentDoc.rating?.kp, kp > 0 {
                        Spacer()
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                        Text("КП")
                            .font(.custom("OpenSans-Regular", size: 20))
                            .foregroundColor(Color.grayDE)
                        Text(round(kp))
                            .font(.custom("OpenSans-Regular", size: 20))
                            .foregroundColor(Color.grayDE)
                        Spacer()
                    }
                    if let imdb = currentDoc.rating?.imdb, imdb > 0 {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                        Text("IMDb")
                            .font(.custom("OpenSans-Regular", size: 20))
                            .foregroundColor(Color.grayDE)
                        Text(round(imdb))
                            .font(.custom("OpenSans-Regular", size: 20))
                            .foregroundColor(Color.grayDE)
                        Spacer()
                        Spacer()
                    }
                }
                
                if let description = currentDoc.description {
                    
                    Text("Описание").mainFont()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    Text(description)
                        .font(.custom("OpenSans-Regular", size: 20))
                        .foregroundColor(Color.grayDE)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                    
                }
                
                if let videos = currentDoc.videos?.trailers?[0].url {
                    
                    Text("Трейлер").mainFont()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    
                    YouTubeTrailer(videoURL: videos)
                    
                        .frame(height: 200)
                        .cornerRadius(12)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                    
                }
                if let sim = simToDoc(currentDoc) {
                    MainScrollView(docs: sim, name: "Похожее")
                        .padding(.leading, 16)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.gray1C)
        .toolbarBackground(Color.gray38, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { saveItem()
                }, label: {
                    if !saved {
                        Image(systemName: "bookmark")
                            .foregroundColor(Color.grayDE)
                    } else {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.yellow)
                    }
                })
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.grayDE)
                })
                .buttonStyle(.plain)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            if let url = currentDoc.poster?.url {
                APIManager().loadImage(urlString: url) { image in
                    mainImage = image
                    secondImage = image
                }
            }
            
            if let url = currentDoc.logo?.url {
                APIManager().loadImage(urlString: url) { image in
                    secondImage = image
                    if mainImage == nil{
                        mainImage = image
                    }
                }
            }
        }
    }
    
    private func saveItem(){
       
        if let idNum = currentDoc.id {
            
            if saved {
                savedFilms.removeValue(forKey: idNum)
            } else {
                savedFilms[idNum] = currentDoc
            }
            saved.toggle()
        }
    }
}


    struct MSerialDetails_Previews: PreviewProvider {
        static var previews: some View {
        SerialDetails(currentDoc: testMain[5])
        }
    }

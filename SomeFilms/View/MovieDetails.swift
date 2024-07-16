//
//  MovieDetails.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 11.07.2024.
//

import Foundation
import SwiftUI

struct MovieDetails: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var currentDocument : Doc?
    @State private var mainImage : UIImage? = nil
    @State private var seconary : UIImage? = nil
    @State private var simAndPreq : [Doc]? = nil
    @State private var feedbacks: [Feedback]? = nil
    @State private var saved: Bool = false
    
    var body: some View {
        
        if let currentDoc = currentDocument {
            
            ScrollView {
                
                //MARK: - Верх
                VStack {
                    ZStack() {
                        if let mainImage = mainImage {
                            GeometryReader { geometry in
                                
                                Image(uiImage: mainImage)
                                    .resizable()
                                    .clipped()
                                
                                    .frame(alignment: .top)
                                    .clipped()
                                    .scaledToFill()
                                
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, Color.gray1C]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }.frame(height: 400)
                        }
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                
                                VStack(alignment: .leading) {
                                    if let name = currentDoc.name {
                                        Text(name).mainFont()
                                    }
                                    
                                    if let leginth = currentDoc.movieLength, leginth != 0 {
                                        Text(workWithLeginth(leginth))
                                            .font(.custom("OpenSans-Regular", size: 20))
                                            .foregroundColor(Color.grayDE)
                                    }
                                    if let genres = currentDoc.genres {
                                        HStack {
                                            ForEach(0..<min(genres.count, 2)) {count in
                                                
                                                Circle()
                                                    .frame(width: 6, height: 6)
                                                    .foregroundColor(Color.gray77)
                                                
                                                Text(genres[count].name!)
                                                    .font(.custom("OpenSans-Regular", size: 16))
                                                    .foregroundColor(Color.grayDE)
                                                    .lineLimit(1)
                                            }
                                        }
                                    }
                                    
                                    if let kp = currentDoc.rating?.kp, kp > 0 {
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(Color.yellow)
                                            Text("КП")
                                                .font(.custom("OpenSans-Regular", size: 20))
                                                .foregroundColor(Color.grayDE)
                                            Text(round(kp))
                                                .font(.custom("OpenSans-Regular", size: 20))
                                                .foregroundColor(Color.grayDE)
                                        }
                                    }
                                    
                                    if let imdb = currentDoc.rating?.imdb, imdb > 0 {
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(Color.yellow)
                                            Text("IMdb")
                                                .font(.custom("OpenSans-Regular", size: 20))
                                                .foregroundColor(Color.grayDE)
                                            Text(round(imdb))
                                                .font(.custom("OpenSans-Regular", size: 20))
                                                .foregroundColor(Color.grayDE)
                                        }
                                        
                                        Button{
                                            
                                        } label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .frame(width: 160, height: 30)
                                                Text("Смотреть")
                                                    .foregroundStyle(Color.grayDE)
                                            }
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                if let seconary = seconary {
                                    Image(uiImage: seconary)
                                    
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 140, height: 200)
                                        .clipped()
                                        .cornerRadius(12)
                                    
                                    Spacer()
                                    
                                } else {
                                    Spacer()
                                    Spacer()
                                }
                            }
                            
                        }
                        
                    }
                    
                    .clipped()
                    .frame(height: 360)
                    .frame(alignment: .top)
                }
                .padding(.bottom, 16)
                
                
                
                //MARK: - Описание
                
                if let desc = currentDoc.description {
                    Text("Описание").mainFont()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    Text(desc)
                        .font(.custom("OpenSans-Regular", size: 20))
                        .foregroundColor(Color.grayDE)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                }
                
                
                
                //MARK: - Трейлер
                if let trailer = currentDoc.videos{
                    Text("Трейлер").mainFont()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    
                    YouTubeTrailer(videoURL: "https://www.youtube.com/embed/ZsJz2TJAPjw")
                    
                        .frame(height: 200)
                        .cornerRadius(12)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                }
                
                
                //MARK: - Комментарии
                if let feedbacks = feedbacks {
                    Text("Комментарии").mainFont()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    VStack {
                        ForEach(0..<min(3, feedbacks.count)) {i in
                            var currentFeedback = feedbacks[i]
                            
                            VStack {
                                HStack {
                                    if let author = currentFeedback.author {
                                        Text(author)
                                            .font(.headline)
                                            .frame(alignment: .leading)
                                            .lineLimit(1)
                                            .font(.custom("OpenSans-SemiBold", size: 20))
                                            .foregroundColor(Color.grayDE)
                                    }
                                    Spacer()
                                    Image(systemName: "hand.thumbsup")
                                        .foregroundColor(Color.grayA4)
                                    
                                    Image(systemName: "hand.thumbsdown")
                                        .foregroundColor(Color.grayA4)
                                }
                                .padding(.leading, 8)
                                .padding(.trailing, 8)
                                
                                
                                HStack {
                                    if let review = currentFeedback.review {
                                        Text(review)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                            .font(.custom("OpenSans-Regular", size: 20))
                                            .foregroundColor(Color.grayDE)
                                        Spacer()
                                    }
                                }
                                .padding(.leading, 8)
                                
                                RoundedRectangle(cornerRadius: 1)
                                    .frame(height: 1)
                                    .padding(3)
                                    .foregroundColor(Color.grayA4)
                                
                                if i+1 == min(3, feedbacks.count) {
                                    HStack {
                                        Text("Показать все")
                                            .font(.custom("OpenSans-Regular", size: 20))
                                            .foregroundColor(Color.grayDE)
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                            
                        }
                        .padding(.leading, 8)
                        .padding(.trailing, 8)
                        
                        
                    }
                    .frame(height: 400)
                    
                    .background(Color.gray24)
                    .cornerRadius(12)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                }
                
                
                
                
                if let simAndPreq = simAndPreq {
                    MainScrollView(docs: simAndPreq, name: "Похожее")
                }
                
            }
            
            //MARK: - onAppear
            .onAppear(){
                
                simAndPreq = simToDoc(currentDoc)
                
                if let idNum = currentDoc.id {
                    if savedFilms[idNum] != nil {
                        saved = true
                    }
                }
                
                if let url = currentDoc.poster?.url {
                    APIManager().loadImage(urlString: url) { image in
                        mainImage = image
                        seconary = image
                    }
                }
                
                if let url = currentDoc.logo?.url {
                    APIManager().loadImage(urlString: url) { image in
                        seconary = image
                        if mainImage == nil{
                            mainImage = image
                        }
                    }
                }
                
                
  //              feedbacks = testReview
                if let id = currentDoc.id {
                    APIManager().getFeedbacks(id) { data in
                        feedbacks = data
                    }
                }
            }
            
            
            .edgesIgnoringSafeArea(.top)
            .background(Color.black1C)
            .toolbarBackground(Color.gray38, for: .navigationBar)
            .toolbar {
                
                ToolbarItem(placement:  .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color.grayDE)
                    })
                    .buttonStyle(.plain)
                }
                
                
                
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
            } .background(Color.clear)
                .navigationBarBackButtonHidden(true)
        }
    }
    
    private func saveItem(){
       
        if let idNum = currentDocument?.id {
            
            if savedFilms[idNum] != nil {
                savedFilms[idNum] = nil
            } else {
                savedFilms[idNum] = currentDocument!
            }
            saved.toggle()
        }
    }
}
    


struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(currentDocument: testMain[6])
    }
}

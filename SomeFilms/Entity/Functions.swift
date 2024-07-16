//
//  Functions.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 16.07.2024.
//

import Foundation
import SwiftUI

func deleteWithoutImageFromDoc(doc: [Doc]) -> [Doc] {
    var newDoc : [Doc] = []
    
    for i in 0..<doc.count {
        if doc[i].logo?.url != nil || doc[i].poster?.url != nil {
            newDoc.append(doc[i])
        }
    }
    
    return newDoc
}


func round(_ number : Double) -> String {
    let roundedString = String(format: "%.2f", number)
    return roundedString
}


func workWithLeginth(_ leginth : Int) -> String {
    
    let mins = leginth % 20
    let hours = (leginth - mins) / 60
    
    if mins == 0 {
        return "\(hours) ч"
    }
    
    if hours == 0 {
        return "\(mins) мин"
    }
    
    
    
    return "\(hours) ч \(mins) мин"
}

// Получает список похожих и продолжений и возвращает их массив

func simToDoc(_ doc: Doc) -> [Doc]? {
    
    let sim = doc.similarMovies
    let preq = doc.sequelsAndPrequels
    
    var returnArray : [Doc] = []
    if let sim = sim {
        for currentSim in sim {
            let returnDoc : Doc = Doc(id: currentSim.id, externalID: nil, name: currentSim.name, alternativeName: currentSim.alternativeName, enName:  nil, names: nil, type: nil, typeNumber: nil, year: currentSim.year, description: nil, shortDescription: nil, slogan: nil, status: nil, rating: nil, votes: nil, movieLength: nil, totalSeriesLength: nil, seriesLength: nil, ratingMPAA: nil, ageRating: nil, poster: currentSim.poster, backdrop: nil, genres: nil, countries: nil, persons: nil, budget: nil, premiere: nil, sequelsAndPrequels: nil, watchability: nil, top10: nil, top250: nil, isSeries: nil, audience: nil, ticketsOnSale: nil, lists: nil, networks: nil, createdAt: nil, updatedAt: nil, videos: nil, fees: nil, facts: nil, logo: nil, reviewInfo: nil, seasonsInfo: nil, similarMovies: nil, releaseYears: nil, isFake: true)
            returnArray.append(returnDoc)
        }
    }
    
    if let preq = preq {
        for currentPreq in preq {
            let returnDoc : Doc = Doc(id: currentPreq.id, externalID: nil, name: currentPreq.name, alternativeName: currentPreq.alternativeName, enName:  nil, names: nil, type: nil, typeNumber: nil, year: currentPreq.year, description: nil, shortDescription: nil, slogan: nil, status: nil, rating: nil, votes: nil, movieLength: nil, totalSeriesLength: nil, seriesLength: nil, ratingMPAA: nil, ageRating: nil, poster: currentPreq.poster, backdrop: nil, genres: nil, countries: nil, persons: nil, budget: nil, premiere: nil, sequelsAndPrequels: nil, watchability: nil, top10: nil, top250: nil, isSeries: nil, audience: nil, ticketsOnSale: nil, lists: nil, networks: nil, createdAt: nil, updatedAt: nil, videos: nil, fees: nil, facts: nil, logo: nil, reviewInfo: nil, seasonsInfo: nil, similarMovies: nil, releaseYears: nil, isFake: true)
            returnArray.append(returnDoc)
        }
    }
    
    if returnArray.count == 0 {
    return nil
    }
    
    return returnArray
    
}




func openDetail<DetailView: View>(_ doc: Doc, someView: DetailView) -> AnyView? {
    
    var newSomeView : AnyView? = nil
    
    if doc.isFake == true, let id = doc.id {
        
        APIManager().getByID(id: id) { newDoc in
            
            if let newDoc = newDoc{
                newSomeView = create(newDoc, someView: someView)
            }
            
        }
    } else {
        newSomeView = create(doc, someView: someView)
    }
    
    
    
    return newSomeView
    
    
    
    
    func create<DetailView: View>(_ doc: Doc, someView: DetailView) -> AnyView{
        
        
        var bool = false
        
        if let ser = doc.isSeries {
            bool = ser
        }
        if bool {
            return AnyView(NavigationLink(destination: SerialDetails(currentDoc: doc)) {
                someView
            })
        }
        else {
            return AnyView(NavigationLink(destination: MovieDetails(currentDocument: doc)) {
                someView
            })
        }
    }
}

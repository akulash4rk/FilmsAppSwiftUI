//
//  RandomFilmsScroll.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 14.07.2024.
//

import Foundation
import SwiftUI

struct RandomFilmsScroll: View {
    
    @State var randomFilms: [Doc]?
    
    @State private var currentImages: [UIImage?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
    
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                if let randomFilms {
                    let minCount = min(10, randomFilms.count)
                    ForEach(0..<minCount) { index in
                        if let image = currentImages[index] {
                            
                            openDetail(randomFilms[index], someView:
                                        Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 290, height: 220)
                                .cornerRadius(12)
                                .clipped()
                            )
                        }
                    }
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
        
        .onAppear(){
            
            if let some = randomFilms {
                
                for index in 0..<min(currentImages.count, some.count)  {
                    
                    let doc = randomFilms![index]
                    
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

#Preview {
    RandomFilmsScroll(randomFilms: testMain)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

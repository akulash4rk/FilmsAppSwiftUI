//
//  ContentView.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 10.07.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
    @State private var newFilms : [Doc]? = nil
    @State private var popularFilms : [Doc]? = nil
    @State private var top250 : [Doc]? = nil
    @State private var randomFilms : [Doc]? = nil
    @State private var popularSerials : [Doc]? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        if let randomFilms {
                            RandomFilmsScroll(randomFilms: randomFilms)
                        }
                        
                        if let popularFilms = popularFilms {
                            MainScrollView(docs: popularFilms, name: "Популярное")
                        }
                        
                        if let newFilms = newFilms {
                        Text("Скоро выйдет").mainFont()
                            .foregroundStyle(Color.grayDE)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 8, leading: 24, bottom: 0, trailing: 24))
                        
                            CarouselView(currentDoc: newFilms)
                        }
                        
                        if let top250 {
                            MainScrollView(docs: top250, name: "Топ 250")
                        }
                        
                        if let popularSerials {
                            MainScrollView(docs: popularSerials, name: "Сериалы")
                        }
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .background(Color.black1C)
            .toolbar(.visible, for: .tabBar)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addItem, label: {
                        Image(systemName: "list.dash")
                    })
                    .foregroundStyle(Color.fullWhite)
                }
                
                ToolbarItem {
                    Button(action: addItem) {
                        Image(systemName: "magnifyingglass")
                    }.foregroundStyle(Color.fullWhite)
                }
                
                ToolbarItem {
                    Button(action: addItem) {
                        Image(systemName: "square.grid.2x2")
                            
                    }.foregroundStyle(Color.fullWhite)
                }
                
            }
            .toolbarBackground(Color.gray38, for: .tabBar)
            .toolbarBackground(Color.gray38, for: .navigationBar)
        }
        
        .onAppear(){
            let manager = APIManager()
            
//            self.randomFilms = testMain
//            self.newFilms = testMain
//            self.popularFilms = testMain
//            self.popularSerials = testMain
//            self.top250 = testMain
            
//            manager.getRandomPopular { data in
//                self.randomFilms = data
//            }
//            
//             manager.getWaitingFilms{data in
//                 self.newFilms = data
//             }
//            
//            manager.getPopularFilms { data in
//                self.popularFilms = data
//            }
//            
//            manager.getPopularSerials { data in
//                self.popularSerials = data
//            }
//            
//            manager.get250 { data in
//                self.top250 = data
//            }         
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

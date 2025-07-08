//
//  ContentView.swift
//  Paws
//
//  Created by Josh Gdovin on 7/7/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query private var pets: [Pet]
    
    @State private var path = [Pet]()
    @State private var isEditing: Bool = false
    
    let layout = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120))
    ]
    // add pet to the database
    func addPet() {
        isEditing = false
        let pet = Pet(name: "Best Friend")
        modelContext.insert(pet)
        path = [pet]
    }


    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: layout) {
                    GridRow {
                        ForEach(pets) { pet in
                            NavigationLink(value: pet) {
                                VStack {
                                    if let imageData = pet.photo {
                                        if let image = UIImage(data: imageData) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                                                //.aspectRatio(contentMode: .init(rawValue: 3))
                                        }
                                    }else {
                                        Image(systemName: "pawprint.circle")
                                             .resizable()
                                             .scaledToFit()
                                             .padding(50)
                                             .foregroundStyle(.quaternary)
                                     }
                                    Spacer()
                                    Text(pet.name)
                                        .font(.title2.weight(.light))
                                        .padding(.vertical)
                                }//: VSTACK
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                                .overlay(alignment: .topTrailing) {
                                    if isEditing {
                                        Menu {
                                            Button("Delete", systemImage: "trash", role: .destructive){
                                                withAnimation{
                                                    modelContext.delete(pet)
                                                    try? modelContext.save()
                                                }
                                            }
                                        } label: {
                                            Image(systemName: "trash.circle.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 32, height: 32)
                                                .foregroundStyle(.red)
                                                .symbolRenderingMode(.multicolor)
                                                .padding()
                                        }
                                    }
                                }
                            }//: NAVLINK
                            .foregroundStyle(.primary)
                        }//: LOOP
                    }//: GRID ROW
                }//: GRID LAYOUT
                .padding(.horizontal)
            }//: SCROLLVIEW
            .navigationTitle(pets.isEmpty ? "" : "Paws")
            // tells the nav where to go and what view to load
            .navigationDestination(for: Pet.self, destination: EditPetView.init)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            isEditing.toggle()
                        }
                    } label: {
                       Image(systemName: "slider.horizontal.3")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add a New pet",systemImage: "plus.circle", action: addPet)
                }
            }
            .overlay{
                if pets.isEmpty {
                    CustomContentUnavailableView(
                        icon: "dog.circle",
                        title: "No Pets",
                        description: "Add a new pet to get started.")
                }
            }
        }//: NAVSTACK
    }
}

#Preview ("Sample Data") {
    ContentView()
        .modelContainer(Pet.preview)
}


#Preview ("No Data") {
    ContentView()
        .modelContainer(for: Pet.self, inMemory: true)
}

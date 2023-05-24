//
//  ContentView.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import MapKit
import SwiftUI

struct MainView: View {
    
    @State private var showingDetails = false
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    Map(coordinateRegion: $mainViewModel.mapRegion, annotationItems: mainViewModel.stations) { station in
                        MapAnnotation(coordinate: station.coordinate) {
                            VStack {
                                Circle()
                                    .frame(width: 35, height: 35)
                                    .overlay {
                                            Image(systemName: "mappin.circle.fill")
                                                .foregroundColor(
                                                    station.isRedWarning ? .red
                                                    : station.isYellowWarning ? .yellow
                                                    : .white
                                                )
                                                .font(.system(size: 30, weight: .bold))
                                    }
                                    
                            }
                            .onTapGesture {
                                mainViewModel.selectedStation = station
                                showingDetails = true
                            }
                        }
                    }
                }
                .tabItem {
                    Label("Mapa", systemImage: "map")
                }
                
                StationListView(showingDetails: $showingDetails, mainViewModel: mainViewModel)
                    .tabItem {
                        Label("Lista stacji", systemImage: "list.bullet")
                    }
            }
            //.padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Ostatnia aktualizacja:").font(.subheadline)
                        if let time = mainViewModel.lastUpdated {
                            Text(time, style: .time).font(.subheadline)
                        } else {
                            Text("(nigdy)").font(.subheadline)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        ForEach(River.list, id: \.id) { river in
                            Text(river.name)
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("refresh")
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }

                }
            }
            .navigationTitle(Text("Mleczka"))
            .sheet(isPresented: $showingDetails) {
                StationDetailsView(station: mainViewModel.selectedStation!)
            }
            .onAppear() {
                mainViewModel.getStations()
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

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
                            StationMapPoint(warningLevel: station.isRedWarning ? .red
                                            : station.isYellowWarning ? .yellow
                                            : .white,
                                            progress: station.warningLevelProgress)
                            .onTapGesture {
                                mainViewModel.selectedStation = station
                                showingDetails = true
                            }
                        }
                    }
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(white: 0.9))
                            .padding(0)
                            .frame(height: 30)
                            .background(Color(UIColor.lightGray))
                        Text("https://monitoring.prospect.pl/")
                    }
                    .offset(y: -8)
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
                            Button(river.name) {
                                mainViewModel.selectedRiver = river
                                print(river.name)
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        mainViewModel.refresh()
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
                mainViewModel.refresh()
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

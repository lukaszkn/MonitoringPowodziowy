//
//  StationListView.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import SwiftUI

struct StationListView: View {
    
    @Binding var showingDetails: Bool
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        List {
            ForEach(mainViewModel.stations) { station in
                VStack(alignment: .leading) {
                    Text(station.miejsce)
                        .font(.title3)
                        .onTapGesture {
                            mainViewModel.selectedStation = station
                            showingDetails = true
                        }
                    VStack {
                        Text("h = \(station.wartosc)cm (\(station.p_ostrzegawczy)cm / \(station.p_alarmowy)cm)")
                            .font(.subheadline)
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                            .background(
                                station.isRedWarning ? .red
                                    : station.isYellowWarning ? .yellow
                                    : .white
                            )
                            .cornerRadius(15)
                    }
                }
                
            }
        }
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var showingDetails = false
        let viewModel = MainViewModel()
        
        StationListView(showingDetails: $showingDetails, mainViewModel: viewModel)
            .onAppear() {
                viewModel.getStations()
            }
    }
}

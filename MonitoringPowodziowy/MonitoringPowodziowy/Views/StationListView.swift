//
//  StationListView.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import SwiftUI

struct StationListView: View {
    
    @Binding var selectedStation: StationData?
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        List {
            ForEach(mainViewModel.stations) { station in
                VStack(alignment: .leading) {
                    Text(station.miejsce)
                        .font(.title3)
                        .onTapGesture {
                            selectedStation = station
                        }
                    Text("h = \(station.wartosc)cm (\(station.p_ostrzegawczy)cm / \(station.p_alarmowy)cm)")
                        .font(.subheadline)
                }
            }
        }
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var station: StationData? = StationData(dl_geo: "0", szer_geo: "0")
        let viewModel = MainViewModel()
        
        StationListView(selectedStation: $station,
                        mainViewModel: viewModel)
            .onAppear() {
                viewModel.getStations()
            }
    }
}

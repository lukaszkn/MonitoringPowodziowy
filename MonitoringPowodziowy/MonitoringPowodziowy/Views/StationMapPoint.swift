//
//  StationMapPoint.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 07/06/2023.
//

import SwiftUI

struct StationMapPoint: View {
    let warningLevel: StationWarningLevel
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 37, height: 37)
            
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(
                    warningLevel == .red ? .red
                    : warningLevel == .yellow ? .yellow
                    : .white
                )
            
            Circle()
                .stroke(
                    Color.yellow.opacity(0.1), lineWidth: 3)
                .frame(width: 28, height: 28)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    warningLevel == .white ? .yellow : .red,
                    style: StrokeStyle(
                        lineWidth: 3,
                        lineCap: .round
                    )
                )
                .frame(width: 28, height: 28)
                .rotationEffect(.degrees(-90))
        }
    }
}

struct StationMapPoint_Previews: PreviewProvider {
    static var previews: some View {
        StationMapPoint(warningLevel: .white, progress: 0.7)
    }
}

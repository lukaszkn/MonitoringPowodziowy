//
//  MonitoringWidgetBundle.swift
//  MonitoringWidget
//
//  Created by Lukasz on 02/01/2024.
//

import WidgetKit
import SwiftUI

@main
struct MonitoringWidgetBundle: WidgetBundle {
    var body: some Widget {
        MonitoringWidget()
        MonitoringWidgetLiveActivity()
    }
}

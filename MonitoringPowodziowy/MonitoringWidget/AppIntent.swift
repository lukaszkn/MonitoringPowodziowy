//
//  AppIntent.swift
//  MonitoringWidget
//
//  Created by Lukasz on 02/01/2024.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Punkt pomiarowy", default: "😃")
    var favoriteEmoji: String
}

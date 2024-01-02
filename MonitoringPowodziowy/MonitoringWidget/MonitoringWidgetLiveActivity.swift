//
//  MonitoringWidgetLiveActivity.swift
//  MonitoringWidget
//
//  Created by Lukasz on 02/01/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MonitoringWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MonitoringWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MonitoringWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MonitoringWidgetAttributes {
    fileprivate static var preview: MonitoringWidgetAttributes {
        MonitoringWidgetAttributes(name: "World")
    }
}

extension MonitoringWidgetAttributes.ContentState {
    fileprivate static var smiley: MonitoringWidgetAttributes.ContentState {
        MonitoringWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MonitoringWidgetAttributes.ContentState {
         MonitoringWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MonitoringWidgetAttributes.preview) {
   MonitoringWidgetLiveActivity()
} contentStates: {
    MonitoringWidgetAttributes.ContentState.smiley
    MonitoringWidgetAttributes.ContentState.starEyes
}

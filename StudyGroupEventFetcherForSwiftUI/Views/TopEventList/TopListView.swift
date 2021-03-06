//
//  TopListView.swift
//  StudyGroupEventFetcherForSwiftUI
//
//  Created by Takuya Aso on 2019/11/01.
//  Copyright © 2019 Takuya Aso. All rights reserved.
//

import SwiftUI

struct TopListView: View {

    // let eventsData: [Event] = mockEventsData
    @ObservedObject private var topListVM = TopListViewModel()

    var body: some View {
        NavigationView {
            List(topListVM.eventData) { event in
                NavigationLink(destination: EventDetailView(eventData: event)) {
                    EventRowView(eventData: event)
                }
            }
            .navigationBarTitle(Text("YUMEMI.swift一覧"))
        }
    }
}

struct TopListView_Previews: PreviewProvider {
    static var previews: some View {
        TopListView()
    }
}

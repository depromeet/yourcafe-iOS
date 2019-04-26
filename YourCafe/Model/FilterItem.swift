//
//  FilterItem.swift
//  YourCafe
//
//  Created by 이동건 on 21/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

struct FilterItem {
    static let bundles: [FilterItem] = [
        FilterItem(optionIconName: "icon_filtering_parking.png",
                   optionIconSelectedName: "icon_filtering_parking_selected.png",
                   optionTitle: "주차장"),
        FilterItem(optionIconName: "icon_filtering_smoking.png",
                   optionIconSelectedName: "icon_filtering_smoking_selected.png",
                   optionTitle: "흡연실"),
        FilterItem(optionIconName: "icon_filtering_24hours.png",
                   optionIconSelectedName: "icon_filtering_24hours_selected.png",
                   optionTitle: "24시간"),
        FilterItem(optionIconName: "icon_filtering_reservation.png",
                   optionIconSelectedName: "icon_filtering_reservation_selected.png",
                   optionTitle: "예약가능"),
        FilterItem(optionIconName: "icon_filtering_food.png",
                   optionIconSelectedName: "icon_filtering_food_selected.png",
                   optionTitle: "외부음식"),
        FilterItem(optionIconName: "icon_filtering_people.png",
                   optionIconSelectedName: "icon_filtering_people_selected.png",
                   optionTitle: "6인 이상"),
        FilterItem(optionIconName: "icon_filtering_toilet.png",
                   optionIconSelectedName: "icon_filtering_toilet_selected.png",
                   optionTitle: "남녀 분리 화장실"),
        FilterItem(optionIconName: "icon_filtering_power.png",
                   optionIconSelectedName: "icon_filtering_power_selected.png",
                   optionTitle: "콘센트"),
        ]
    var optionIconName: String
    var optionIconSelectedName: String
    var optionTitle: String
}


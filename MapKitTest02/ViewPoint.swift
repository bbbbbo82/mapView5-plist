//
//  ViewPoint.swift
//  MapKitTest02
//
//  Created by D7703_15 on 2019. 10. 7..
//  Copyright © 2019년 bohyun. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ViewPoint: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    // 생성자함수 init
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

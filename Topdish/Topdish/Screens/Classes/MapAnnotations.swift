//
//  MapAnnotations.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-08.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotations: NSObject,MKAnnotation {

    var title : String?
    var subTit : String?
    var coordinate : CLLocationCoordinate2D

    init(title:String,coordinate : CLLocationCoordinate2D){
        self.title = title;
        self.coordinate = coordinate;
    }

    override init() {
        self.title = ""
        self.coordinate =  CLLocation(latitude: 38, longitude: 22).coordinate
    }
}


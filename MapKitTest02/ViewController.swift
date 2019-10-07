//
//  ViewController.swift
//  MapKitTest02
//
//  Created by D7703_15 on 2019. 9. 16..
//  Copyright © 2019년 bohyun. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    // 배열 선언
    var pins = [MKAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        // MapType 설정 (standard, hybrid, satellite)
        mapView.mapType = MKMapType.standard
        
        // MKMapViewDelegate와 UIViewController(self)
        mapView.delegate = self
        
        // plist 화일 불러오기
        let path = Bundle.main.path(forResource: "myData", ofType: "plist")
        print(path!)
        
        // 화일의 내용
        let contents = NSArray(contentsOfFile: path!)
        print(contents!)
        
        // 화일 내용 처리
        // optional binding 하기
        if let myItems = contents {
            for item in myItems {
                
                let lat = (item as AnyObject).value(forKey: "lat")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subTitle = (item as AnyObject).value(forKey: "subTitle")
                
                // 위도, 경도 String에서 double로 형변환
                let myLat = (lat as! NSString).doubleValue
                let myLong = (long as! NSString).doubleValue
                
                let pin = MKPointAnnotation()
                
                pin.coordinate.latitude = myLat
                pin.coordinate.longitude = myLong
                pin.title = title as? String
                pin.subtitle = subTitle as? String
                
                // pins 배열에 append
                pins.append(pin)
            }
        } else {
            // 아이템이 없을 때
            print("nil 발생")
        }
        // mapView의 모든 pin들을 한 화면에 나타냄
        mapView.showAnnotations(pins, animated: true)
    }
    
    // MapType 버튼 설정 (standard, hybrid, satellite)
    @IBAction func standardTypeButton(_ sender: Any) {
        mapView.mapType = MKMapType.standard
    }
    
    @IBAction func hybridTypeButton(_ sender: Any) {
        mapView.mapType = MKMapType.hybrid
    }
    
    @IBAction func satelliteTypeButton(_ sender: Any) {
        mapView.mapType = MKMapType.satellite
    }
    
    
    // MKMapViewDelegate 메소드
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // pin의 재활용
        let identifier = "RE"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        // 재활용할 pin이 없으면 pin 생성
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            //annotationView?.pinTintColor = UIColor.blue   // pin 색깔 변경
            annotationView?.animatesDrop = true
            
            // 오른쪽 : 상세정보 버튼
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
        } else {
            annotationView?.annotation = annotation
        }
        
        // 왼쪽 : 이미지 넣기
        var imgV = UIImageView()
        
        // pin색깔, 이미지 변경
        if annotation.title! == "동의과학대학교"  {
            annotationView?.pinTintColor = UIColor.red
            imgV = UIImageView(image: UIImage(named: "dit.png"))
        } else if annotation.title! == "부산시민공원"  {
            annotationView?.pinTintColor = UIColor.black
            imgV = UIImageView(image: UIImage(named: "cat.jpg"))
        } else if annotation.title! == "광안대교"  {
            annotationView?.pinTintColor = UIColor.blue
            imgV = UIImageView(image: UIImage(named: "광안대교.png"))
        } else {
            annotationView?.pinTintColor = UIColor.purple
            imgV = UIImageView(image: UIImage(named: "태종대.png"))
        }
        
        imgV.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        annotationView?.leftCalloutAccessoryView = imgV
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        // 알림창 객체 생성
        let alert = UIAlertController(title: (view.annotation?.title)!, message: (view.annotation?.subtitle)!, preferredStyle: .alert)
        
        // 확인 버튼
        let ok = UIAlertAction(title:"확인", style: .default)
        
        // 버튼을 컨트롤러에 등록
        alert.addAction(ok)
        
        // 알림창 실행
        self.present(alert, animated: false)
        
    }
}


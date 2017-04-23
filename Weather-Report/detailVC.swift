//
//  detailVC.swift
//  Weather-Report
//
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class detailVC: UIViewController {

    @IBOutlet weak var forweatherImg: UIImageView!
    @IBOutlet weak var lb: UILabel!
    @IBOutlet weak var formintempLbl: UILabel!
    @IBOutlet weak var formaxtempLbl: UILabel!
    @IBOutlet weak var forHumLbl: UILabel!
    @IBOutlet weak var forPressureLbl: UILabel!
    @IBOutlet weak var forRainLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    var fmaxTemp:Double!
    var fminTemp:Double!
    var fhumidity:Double!
    var fpressure:Double!
    var forecastWeather = ForecastWeather()
    var fcurrentweatherType:String!
    var fdate:String!

    
    @IBOutlet weak var cLbl: UILabel!
    @IBOutlet weak var pLbl: UILabel!
    @IBOutlet weak var mLbl: UILabel!
    @IBOutlet weak var Hlbl: UILabel!
    @IBOutlet weak var minLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fcurrentweatherType == "Rain" {
            addgifs(type: "rainy")
        }
        if fcurrentweatherType == "Snow" {
            addgifs(type: "snowy")
        }
        if fcurrentweatherType == "Clear" {
            addgifs(type: "sunny")
        }
        if fcurrentweatherType == "Clouds" {
            addgifs(type: "cloudy")
        }

        formintempLbl.text = "\(fmaxTemp!)"
        formaxtempLbl.text = "\(fmaxTemp!)"
        forHumLbl.text = "\(fhumidity!)"
        forPressureLbl.text = "\(fpressure!)"
        let randomnumber:UInt32 = arc4random_uniform(30)
        forRainLbl.text = "\(randomnumber)"+"%"
        forweatherImg.image = UIImage(named: fcurrentweatherType)
        lb.text = fdate
        self.view.addSubview(lb)
        self.view.addSubview(formaxtempLbl)
        self.view.addSubview(formintempLbl)
        self.view.addSubview(forPressureLbl)
        self.view.addSubview(forHumLbl)
        self.view.addSubview(forweatherImg)
        self.view.addSubview(forRainLbl)
        self.view.addSubview(cLbl)
        self.view.addSubview(pLbl)
        self.view.addSubview(mLbl)
        self.view.addSubview(Hlbl)
        self.view.addSubview(minLbl)
        self.view.addSubview(backBtn)

        

    }
    
    func addgifs(type:String){
        do{
            let imageData = try Data(contentsOf: Bundle.main.url(forResource: type, withExtension: "gif")!)
            let imageGif = UIImage.gifWithData(data: imageData as NSData)
            let imageView = UIImageView(image: imageGif)
            imageView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
            view.addSubview(imageView)
        } catch let error as NSError {
            print(error.localizedDescription)
        }

    }
    
    @IBAction func backBtnPrssd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    

   

}

//
//  ViewController.swift
//  AddcardApp
//
//  Created by Priya on 3/17/20.
//  Copyright © 2020 ZSL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 var arrBanner : [String] =  ["https://netstorage-legit.akamaized.net/images/725f83c62e913373.png?imwidth=900","https://media.mnn.com/assets/images/2016/06/In%20my%20food%20world,%20there%20is%20no%20fear%20or%20guilt,%20only%20joy%20and%20balance..jpg.838x0_q80.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSk_jY7BlaaBVzN_S9Li9VZcOZ6JUxfpVNfIAvkcdfptCLfXEbr","https://media-cdn.tripadvisor.com/media/photo-s/19/5c/27/e5/what-a-wonderful-spread.jpg","https://www.sydneycommercialkitchens.com.au/images/blog/SCK_Luciano_Pavarotti_Quote.png","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQeRT94-FMEsugoIka2eeLHR1VVChr1B0JPj3WheNj2EiiXkOTh"]

    
    let concurrent = DispatchQueue(label: Bundle.main.bundleIdentifier!+"..ConcurrentQuee", qos: .utility, attributes: .concurrent)
    lazy var horizontalMainContent : CGSize = {
        let size = CGSize(width: (self.view.frame.size.width * CGFloat(self.arrBanner.count)) - 250 , height: 200)
        return size
    }()
    
    lazy var horizontalMainScroll : UIScrollView = {
        let scroll = UIScrollView(frame : .zero)
        scroll.frame = CGRect(x: 0, y: 50, width:self.view.frame.size.width, height:200)
        scroll.backgroundColor = .orange
        scroll.contentSize = self.horizontalMainContent
        scroll.autoresizingMask =  .flexibleWidth  //.flexibleHeight
        scroll.bounces = true
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    lazy var ADContentView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.frame.size = self.horizontalMainContent
        return view
    }()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "cart"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(openOrderView), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 40)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        //let orderButton = UIBarButtonItem(title: "OrderMy", style: UIBarButtonItemStyle.plain, target: self, action: #selector(openOrderView))
        //self.navigationItem.rightBarButtonItem = orderButton
        // Do any additional setup after loading the view, typically from a nib.
        viewInitMethod()
        scrollBannerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewInitMethod() -> Void {
    self.view.addSubview(self.horizontalMainScroll)
    self.horizontalMainScroll.addSubview(self.ADContentView)
//    self.ADContentView.addSubview(Banner)
//    self.view.addSubview(self.scrollView)
//    self.scrollView.addSubview(self.viewContainer)
//    self.viewContainer.addSubview(lblCenter)
//    
//    lblCenter.snp.makeConstraints { (mark) -> Void in
//    //mark.center.equalToSuperview()
//    mark.center.equalTo(self.viewContainer)
//    }
    print("count -> : \(self.view.subviews.count)")
    for view in self.view.subviews {
    print(view)
    }
    }
    func scrollBannerView() -> Void{
        
        for i in 0..<arrBanner.count {
            print(i)
            if i == 0 {
                self.ADContentView.addSubview(addBanners(position : CGFloat(5),index: i))
            }else {
                let widths : CGFloat = (self.view.frame.size.width - 50) * CGFloat(i)
                self.ADContentView.addSubview(addBanners(position : widths,index: i))
            }
        }
        
    }
    
    func addBanners(position : CGFloat,index : Int) ->UIView {
        print("1\n")
        let Banner : UIView = {
            let view = UIView()
            let widths : CGFloat = self.view.frame.size.width - 70
            view.frame.size = CGSize( width: widths, height: 160)
            view.frame.origin.x = CGFloat(position)
            view.frame.origin.y = 30
            view.backgroundColor  = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            view.clipsToBounds = true
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.darkGray.cgColor
            view.layer.shadowRadius = 8
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.cornerRadius = 10
            return view
        }()
        
        concurrent.async {
        let url = URL(string:self.arrBanner[index])
        let dataImg = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
        let imgView : UIImageView = UIImageView()
        imgView.frame = CGRect(x: 0, y: 0, width:Banner.frame.size.width , height: Banner.frame.size.height)
        imgView.image = UIImage(data: dataImg!)
        Banner.addSubview(imgView)
           }
       }
        
//        let url = URL(string:self.arrBanner[index])
//        let dataImg = try? Data(contentsOf: url!)
//        let imgView : UIImageView = UIImageView()
//        imgView.frame = CGRect(x: 0, y: 0, width:Banner.frame.size.width , height: Banner.frame.size.height)
//        imgView.image = UIImage(data: dataImg!)
//        Banner.addSubview(imgView)
        
//        let label : UILabel = UILabel()
//        label.text = arrBanner[index]
//        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
//        label.frame.size = CGSize(width: (Banner.frame.size.width - 20), height: 20)
//        label.frame = CGRect(x: (Int(Banner.frame.size.width/5)), y: (Int(Banner.frame.size.height/2)) , width: (Int(Banner.frame.size.width - 20)), height: 20)
//        Banner.addSubview(label)
        return Banner
    }
    
  @objc func openOrderView(sender : UIBarButtonItem){
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let newViewController = storyBoard.instantiateViewController(withIdentifier: "MyOrderViewController") as! MyOrderViewController
    newViewController.navigationItem.title = "OrderCheck"
    self.navigationController?.pushViewController(newViewController, animated: true)
    //   self.present(newViewController, animated: true, completion: nil)
    //  performSegue(withIdentifier: "orderItems", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "placeOrder" {
            if let secondViewCtrl = segue.destination as? PlaceOrderViewController{
                secondViewCtrl.navigationItem.title = "placeOrder"

            }
        }
        
        
    }


}


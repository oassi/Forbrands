//
//  EmptyView.swift
//  Apps
//
//  Created by Musbah on 2/23/19.
//  Copyright © 2019 Musbah. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    //@IBOutlet weak var img: UIImageView!
    @IBOutlet weak var firstLabel:UILabel!
    //@IBOutlet weak var secondLabel:UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var emptyViewButtonAction:(() -> ())?

        
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    
    
    @IBAction func emptyViewButton(_ sender: Any) {
        emptyViewButtonAction?()
    }
    
    
}
extension UIViewController{
    
    private struct EmptyViewHolder {
        var shared: EmptyView? = {
            let emptyView =  EmptyView.instantiateFromNib()
            return emptyView
            
        }()
    }
    
    //var emptyView:EmptyView? {
    //    get {
    //        return EmptyViewHolder.init().shared
    //    }
    //}
    
    func showEmptyView(emptyView:EmptyView?, parentView:UIView, refershSelector:Selector?, firstLabel:String? = nil, secondLabel:String? = nil, image:UIImage? = nil)->EmptyView? {
        emptyView?.removeFromSuperview()
        
        if let emptyView = EmptyView.instantiateFromNib() {
            
           emptyView.firstLabel.text = "No results found!".localized
           if let firstLabel = firstLabel{
               emptyView.firstLabel.text = firstLabel
           }
           
           //emptyView.secondLabel.isHidden = true
           //if let secondLabel = secondLabel{
           //    emptyView.secondLabel.isHidden = false
           //    emptyView.secondLabel.text  = secondLabel
           //}
           //
           //if let image = image{
           //    emptyView.img.image = image
           //}

            emptyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:refershSelector))
            
            if let tableView = parentView as? UITableView{
                emptyView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: tableView.frame.height / 1.5)
                tableView.tableFooterView = emptyView
                
            } else if let collectionView = parentView as? UICollectionView{
                collectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: collectionView.frame.height)
                collectionView.backgroundView = emptyView
                
            }else{
                view.addSubview(emptyView)
                NSLayoutConstraint.activate([
                    emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    emptyView.topAnchor.constraint(equalTo: view.topAnchor),
                    emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
                emptyView.translatesAutoresizingMaskIntoConstraints = false
                
            }
            
            return emptyView
            
        }
        return emptyView
    }
}


extension UIView {
    
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    static func instantiateFromNib() -> Self? {
        func instanceFromNib<T: UIView>() -> T? {
            return nib.instantiate() as? T
        }
        
        return instanceFromNib()
    }
    
}

extension UINib {
    
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
    
}

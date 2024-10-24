//
//  Drinks+CoreDataClass.swift
//  Barman
//
//  Created by Israel Aguilar on 10/23/24.
//

import UIKit

class DetailView: UIView {
    let tv = UITextView()
    
    override func draw(_ rect: CGRect) {
        tv.frame = rect
        tv.backgroundColor = .lightGray
        tv.isEditable = false
        tv.font = UIFont.systemFont(ofSize: 22)
        self.addSubview(tv)
    }

}

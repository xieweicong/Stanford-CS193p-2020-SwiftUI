//
//  Array+Only.swift
//  Memorize
//
//  Created by weicongxie on 2020/08/14.
//  Copyright © 2020 weicongxie. All rights reserved.
//

import Foundation

extension Array {
    var Only: Element? {
        count == 1 ? first : nil
    }
}

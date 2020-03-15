//
//  PageInfo.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

struct PageInfo {
    
    static let `default` = PageInfo(current: 1, total: 1)
    
    fileprivate(set) var currentPage: Int
    fileprivate(set) var totalPage: Int
    
    var hasNextPage: Bool {
        return currentPage < totalPage
    }
    
    init(current: Int, total: Int) {
        currentPage = current > 0 ? current : 1
        totalPage = total > 0 ? total : 1
    }
    
    func getNextPage() -> Int {
        return currentPage + 1
    }
    
}


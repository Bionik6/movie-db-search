//
//  PageParser.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import SwiftyJSON


protocol PageParser {
    func parse(data: Data) -> Page
}


final class PageJSONParser: PageParser {
    
    func parse(data: Data) -> Page {
        guard let jsonData = try? JSON(data: data) else { fatalError("Could not create json with the data provided") }
        return Page.init(json: jsonData)
    }

}

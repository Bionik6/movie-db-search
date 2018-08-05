//
//  PageParser.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import SwiftyJSON

/// Parser for translation data to Page object
protocol PageParser {
    func parse(data: Data) -> Page
}


final class PageJSONParser: PageParser {
    
    
    /// Parse data to Page object
    ///
    /// - Parameter data: The data coming from our server response
    /// - Returns: The Page with the movies associated
    func parse(data: Data) -> Page {
        guard let jsonData = try? JSON(data: data) else { fatalError("Could not create json with the data provided") }
        return Page.init(json: jsonData)
    }

}

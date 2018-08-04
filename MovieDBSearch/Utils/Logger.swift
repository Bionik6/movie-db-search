//
//  Logger.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

import Foundation

final class Logger {
    
    func debug(_ message: Any, file: String = #file, line: Int = #line) {
        print("💙 Debug - \(file.split(separator: "/").last!):\(line) => \(message)")
    }
    
    func error(_ message: Any, file: String = #file, line: Int = #line) {
        print("❤️ Error - \(file.split(separator: "/").last!):\(line) => \(message)")
    }
}

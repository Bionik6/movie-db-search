//
//  MainAssembler.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Swinject


/// Main object for assembling all the resolvers we created
final class MainAssembler {
    
    private let assembler = Assembler()
    
    var resolver: Resolver { return assembler.resolver }
    
    init() {
        assembler.apply(assembly: SearchAssembly.init())
    }
    
}

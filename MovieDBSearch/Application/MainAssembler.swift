//
//  MainAssembler.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Swinject

final class MainAssembler {
    
    private let assembler = Assembler()
    
    var resolver: Resolver { return assembler.resolver }
    
    init() {
        assembler.apply(assemblies: [
            SearchAssembly()
            ])
    }
    
}

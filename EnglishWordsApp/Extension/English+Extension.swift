//
//  English+Extension.swift
//  EnglishWordsApp
//
//  Created by 井戸春希 on 2021/04/06.
//

import CoreData
import SwiftUI

extension EnglishWordsEntity {
    
    static func create(in managedObjectContext: NSManagedObjectContext,
                       word_e: String,
                       word_j: String,
                       time: Date? = Date()){
        let new_word = self.init(context: managedObjectContext)
        print(new_word)
        new_word.time = time
        new_word.word_e = word_e
        new_word.word_j = word_j
        new_word.id = UUID().uuidString
        
        do {
            try  managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

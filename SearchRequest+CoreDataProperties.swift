//
//  SearchRequest+CoreDataProperties.swift
//  iTunesFinder
//
//  Created by Илья on 17.11.2021.
//
//

import Foundation
import CoreData


extension SearchRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchRequest> {
        return NSFetchRequest<SearchRequest>(entityName: "SearchRequest")
    }

    @NSManaged public var searchRequest: String?

}

extension SearchRequest : Identifiable {

}

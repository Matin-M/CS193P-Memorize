//
//  Grid.swift
//  Memorize
//
//  Created by Matin Massoudi on 7/14/20.
//  Copyright © 2020 Matin Massoudi. All rights reserved.
//

import SwiftUI

//Generic where clause, Item must conform to Identifiable protocol.
//Generic where clauses constrain generics.
struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    //Function escapes from init.
    init(_ item: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = item
        self.viewForItem = viewForItem
        
    }
    
    var body: some View {
        GeometryReader {
            geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
            }
        }
        
        
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)
        return Group {
            if index != nil {
                viewForItem(item).frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index!))
            }
        }
    }
    
    
}



//
//  Tip.swift
//  Grocery List
//
//  Created by Josh Gdovin on 7/7/25.
//

import Foundation
import TipKit

struct ButtonTip: Tip {
    var title: Text = Text("Essentials Foods")
    var message: Text? = Text("Add some everyday items to the shopping list.")
    var image: Image? = Image(systemName: "info.circle")
}

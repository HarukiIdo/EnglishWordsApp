//
//  ContentView.swift
//  EnglishWordsApp
//
//  Created by 井戸春希 on 2021/03/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            //登録した英単語をリスト表示させるタブ
        ListTabView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

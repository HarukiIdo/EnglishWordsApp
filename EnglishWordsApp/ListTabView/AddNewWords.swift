//
//  AddNewWords.swift
//  EnglishWordsApp
//
//  Created by 井戸春希 on 2021/04/06.
//

import SwiftUI

//+ボタンを押すと単語の追加画面にモーダル遷移する処理を行う
struct AddNewWords: View {
    @Environment(\.managedObjectContext) var viewContext
    @State var addNewWord = false
    var body: some View {
        //floating button
        Button(action: {
            self.addNewWord = true
        }){
            Image(systemName: "plus")
                .frame(width: 60, height: 60)
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .frame(width: 60, height: 60)
        .background(Color.blue)
        .cornerRadius(30.0)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
        
        .sheet(isPresented: $addNewWord, content: {
            NewWords()
                .environment(\.managedObjectContext, self.viewContext)
        })
    }
}

struct AddNewWords_Previews: PreviewProvider {
    static var previews: some View {
        AddNewWords()
    }
}

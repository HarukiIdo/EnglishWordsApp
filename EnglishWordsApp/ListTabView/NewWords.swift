//
//  NewWords.swift
//  EnglishWordsApp
//
//  Created by 井戸春希 on 2021/04/05.
//

import SwiftUI

//単語の追加を行う
struct NewWords: View {
    @State var word_e: String = ""
    @State var word_j: String = ""
    @State var time: Date? = Date()
    @Environment(\.managedObjectContext) var viewContext
    
    //保存処理
    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved Error \(nserror), \(nserror.userInfo)")
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("単語")) {
                    TextField("新しい単語を入力", text: $word_e)
                        .keyboardType(.alphabet)
                }
                Section(header: Text("日本語")) {
                    TextField("意味を入力", text: $word_j)
                }
                Section(header: Text("操作")){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack{
                            Image(systemName: "minus.circle")
                            Text("キャンセル")
                        }.foregroundColor(.red)
                    }
                }
            }.navigationBarTitle("単語の登録")
            .navigationBarItems(trailing: Button(action: {
                EnglishWordsEntity.create(in: self.viewContext, word_e: self.word_e,word_j: self.word_j, time: self.time)
                self.save()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("登録")
            })
        }
    }
}

struct NewWords_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        NewWords()
            .environment(\.managedObjectContext, context)
    }
}

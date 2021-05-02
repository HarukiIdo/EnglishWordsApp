//
//  ListTabView.swift
//  EnglishWordsApp
//
//  Created by 井戸春希 on 2021/04/03.
//

import SwiftUI
import CoreData

struct ListTabView: View {
    
    //データベースからデータを取得することができる
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \EnglishWordsEntity.time, ascending: true)],
                  animation: .default)
    var englishList: FetchedResults<EnglishWordsEntity>
    
    @Environment(\.managedObjectContext) var viewContext
    
    //削除を行うメソッド
    fileprivate func delete(at offsets: IndexSet) {
        for index in offsets {
            let entity = englishList[index]
            //削除
            viewContext.delete(entity)
        }
        do{//削除を保存
            try viewContext.save()
        } catch{
            print("Delete Error. \(offsets)")
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                List{
                    Section(header: Text("All")){
                        ForEach(englishList) { englishWord in
                            NavigationLink(destination: EditWords(word_j: englishWord)){
                                HStack {
                                    Text(englishWord.word_e ?? "no word")
                                    Spacer()
                                }
                            }
                        }.onDelete(perform: delete)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle(Text("My単語帳"))
                .navigationBarItems(trailing: EditButton())
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        AddNewWords()
                            .padding()
                    }
                }
            }
        }
    }
}

struct ListTabView_Previews: PreviewProvider {
    static let container = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer
    static let context = container.viewContext
    
    static var previews: some View {
        //テストデータの削除
        let request = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "EnglishWordsEntity"))
        try! container.persistentStoreCoordinator.execute(request, with: context)
        
        //データの追加
        EnglishWordsEntity.create(in: context, word_e: "NewWord",word_j: "no word")
        
        return ListTabView()
            .environment(\.managedObjectContext, context)
    }
}

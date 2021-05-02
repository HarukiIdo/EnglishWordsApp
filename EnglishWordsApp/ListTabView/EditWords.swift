//
//  EditWords.swift
//  EnglishWordsApp
//
//  Created by 井戸春希 on 2021/04/07.
//
import  SwiftUI

//登録した単語の編集処理
struct EditWords: View {
    @ObservedObject var word_j: EnglishWordsEntity
    @State var showingSheet = false
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
    //削除処理
    fileprivate func delete() {
        viewContext.delete(word_j)
        save()
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form{
            Section(header: Text("意味")) {
                Text(word_j.word_j ?? "no word")
            }
            Section(header: Text("操作")){
                Button(action: {
                    self.showingSheet = true
                }) {
                    HStack{
                        Image(systemName: "minus.circle")
                        Text("削除")
                    }.foregroundColor(.red)
                }
            }
        }.navigationBarTitle("単語の編集")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            self.save()
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("閉じる")
        })
        .actionSheet(isPresented: $showingSheet) {
            ActionSheet(title: Text("単語の削除"), message: Text("この単語を削除します。よろしいですか？"), buttons: [
                .destructive(Text("削除")){
                    self.delete()
                    self.presentationMode.wrappedValue.dismiss()
                },
                .cancel(Text("キャンセル"))
            ])
        }
    }
}

struct EditWords_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        let newWord = EnglishWordsEntity(context: context)
        return NavigationView{
            EditWords(word_j: newWord)
            .environment(\.managedObjectContext, context)
        }
    }
}

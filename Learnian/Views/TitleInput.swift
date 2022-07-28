//
//  TitleInput.swift
//  LearnUp
//
//  Created by Vincentius Ian Widi Nugroho on 25/07/22.
//

import SwiftUI

struct TitleInput: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var learns: FetchedResults<Learn>
    @State private var learnID: Int64 = -1
    @State private var title = ""
    @State private var action = ""
    @State private var saved: Bool = false
    @State private var category = "left"
    
    @State private var learn1: Learn = Learn()
    @State private var reflect1: Reflect = Reflect()
    @Binding var rootIsActive : Bool

    @State var learnPass = Learn()
    
    var body: some View {

        VStack {
            Rectangle().frame(height: 0).background(learnLightBlue)
            // input title
            HStack {
                Text("Title").padding(EdgeInsets(top:15, leading:20, bottom: 0, trailing: 0))
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(learnGray).frame(height:40).padding(.horizontal,20)
                TextField("", text: $title).padding(.horizontal,35)
            }
            
            // toggle category
            HStack {
                Text("Type").padding(EdgeInsets(top:15, leading:20, bottom: 0, trailing: 0))
                Spacer()
            }
            HStack {
                Button(action:{
                    category = "left"
                    print(category)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).fill((category == "left") ? learnBlue : learnGray).frame(width: 100, height: 100, alignment: .center)
                        VStack {
                            Text("what").foregroundColor((category == "left") ? .white : .black)
                            Text("to do").foregroundColor((category == "left") ? .white : .black)
                        }
                    }
                }.buttonStyle(PlainButtonStyle()).padding(.trailing,25)
                Button(action:{
                    category = "right"
                    print(category)
                }) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10).fill((category == "right") ? learnBlue : learnGray
                        ).frame(width: 100, height: 100, alignment: .center)
                        VStack {
                            Text("what").foregroundColor((category == "right") ? .white : .black)
                            Text("i did").foregroundColor((category == "right") ? .white : .black)
                        }
                    }
                }.buttonStyle(PlainButtonStyle()).buttonStyle(PlainButtonStyle()).padding(.leading,25)
            }

            // input action
            HStack {
                Text((category == "left") ? "What do you want to do?" : "What did you do?").padding(EdgeInsets(top:15, leading:20, bottom: 0, trailing: 0))
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(learnGray).frame(height:40).padding(.horizontal,20)
                TextField("", text: $action).padding(.horizontal,35)
            }

            Spacer()
            whichButton(categ: category)
        }
        .navigationTitle("Title")
        .navigationBarTitleDisplayMode(.inline)
    }
    
     func whichButton(categ: String) -> AnyView{
         if(!saved){
             return saveButton()
         } else {
             return nextButton()
         }
    }
    
    func saveLearn(){
        learn1 = Learn(context: moc)
        learn1.id = Int64(learns.count+1)
        learnID = Int64(learns.count+1)
        learn1.title = title
        learn1.status = "learning"

        reflect1 = Reflect(context: moc)
        reflect1.action = action
        reflect1.id = 1
        reflect1.learn = learn1

        self.learnPass = learn1
        
        try? moc.save()
    }
    
     func saveButton() -> AnyView{
        return AnyView(
            Button(action:{
                saved.toggle()
                saveLearn()
                if(category=="left"){
                    self.rootIsActive = false
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(learnBlue).frame(height:40).padding(.horizontal,20)
                    Text("Done").foregroundColor(.white)
                }
            }.padding()
        )
    }
    
    func nextButton() -> AnyView {
        return AnyView(
            NavigationLink(destination: ReflectInput(learnResult: learnPass), label:{
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(learnBlue).frame(height:40).padding(.horizontal,20)
                Text("Next").foregroundColor(.white)
            }
        }).padding().opacity((saved) ? 100 : 0)
        )
    }

    
}

//struct TitleInput_Previews: PreviewProvider {
//    static var previews: some View {
//        TitleInput()
//    }
//}

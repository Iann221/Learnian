//
//  ReflectInput.swift
//  LearnUp
//
//  Created by Vincentius Ian Widi Nugroho on 25/07/22.
//

import SwiftUI

struct ReflectInput: View {
    @Environment(\.managedObjectContext) var moc

     var learnResult: Learn
    
    @State private var well = ""
    @State private var diff = ""
    @State private var notes = ""
    @State private var nextAct = ""
    @State private var category = "left"

    init(learnResult:Learn){
        self.learnResult = learnResult
        UITextView.appearance().backgroundColor = .clear
    }
        
    var body: some View {
        
        VStack {
            Rectangle().frame(height: 0).background(learnLightBlue)
            
            ScrollView{
            inputView()
            
            // next input
            HStack {
                Text("What's your next plan?").padding(EdgeInsets(top:15, leading:20, bottom: 0, trailing: 0))
                Spacer()
            }.opacity((category == "left") ? 100 : 0)
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(learnGray).frame(height:40).padding(.horizontal,20)
                TextField("", text: $nextAct).padding(.horizontal,35)
            }.opacity((category == "left") ? 100 : 0)
            }
            Spacer()
            
            // button done
            Button(action:{
                let allReflek = (learnResult.reflect)!.allObjects as! [Reflect]
                let sortReflek = allReflek.sorted(by:{$0.id < $1.id})
                let countReflek = allReflek.count
                // sort
                let selectedReflek = sortReflek[countReflek-1]

                selectedReflek.well = well
                selectedReflek.diff = diff
                selectedReflek.notes = notes

                if (category == "left"){
                    // want to improve
                    let reflect2 = Reflect(context: moc)
                    reflect2.id = Int64(countReflek+1)
                    reflect2.action = nextAct
                    reflect2.learn = learnResult
                } else {
                    // satisfied
                    learnResult.status = "learned"
                }
                try? moc.save()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(learnBlue).frame(height:40).padding(.horizontal,20)
                    Text("Done").foregroundColor(.white)
                }
            }.padding()
        }
        .navigationTitle("Title")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func inputView() -> AnyView {
        return AnyView(
            VStack{
                // well input
                HStack {
                    Text("What went well?").padding(EdgeInsets(top:15, leading:20, bottom: 0, trailing: 0))
                    Spacer()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(learnGray).frame(height:40).padding(.horizontal,20)
                    TextField("", text: $well).padding(.horizontal,35)
                }
                
                // well input
                HStack {
                    Text("Any difficulties?").padding(EdgeInsets(top:15, leading:20, bottom: 0, trailing: 0))
                    Spacer()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(learnGray).frame(height:40).padding(.horizontal,20)
                    TextField("", text: $diff).padding(.horizontal,35)
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
                                Text("I want to").foregroundColor((category == "left") ? .white : .black)
                                Text("improve").foregroundColor((category == "left") ? .white : .black)
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
                                Text("I'm").foregroundColor((category == "right") ? .white : .black)
                                Text("satisfied").foregroundColor((category == "right") ? .white : .black)
                            }
                        }
                    }.buttonStyle(PlainButtonStyle()).buttonStyle(PlainButtonStyle()).padding(.leading,25)
                }
                
                // notes
                HStack {
                    Text("Notes").padding(EdgeInsets(top:15, leading:20, bottom: 0, trailing: 0))
                    Spacer()
                }
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10).fill(learnGray).frame(height:100).padding(.horizontal,20)
                    TextEditor(text: $notes)
                        .frame(minHeight: 100, alignment: .leading)
                        .cornerRadius(10.0)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal,35)
                }.padding()

            }
        )
    }
}

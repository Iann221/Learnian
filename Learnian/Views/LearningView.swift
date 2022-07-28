//
//  ContentView.swift
//  LearnUp
//
//  Created by Vincentius Ian Widi Nugroho on 24/07/22.
//

import SwiftUI

struct LearningView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)],predicate: NSPredicate(format: "status == %@", "learning")) var learns: FetchedResults<Learn>
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationView {
                VStack {
                    Rectangle().frame(height: 0).background(learnLightBlue)
                    if (learns.count==0){
                        Text("No Learning\nObjective")  .multilineTextAlignment(.center).foregroundColor(.gray).padding(.top,250)
                    }
                    else {
                        ScrollView {
                            ForEach(learns) { learn in
                                
                                // tanpa isactive
        //                        NavigationLink(destination: ActionDetail(learnin: learn), label:{
        //                                HStack {
        //                                    VStack(alignment: .leading, spacing: 5) {
        //                                        Text(learn.title ?? "no data").fontWeight(.semibold)
        //                                        Text(((learn.reflect)!.allObjects as! [Reflect]).sorted(by:{$0.id < $1.id})[((learn.reflect)!.allObjects).count-1].action
        // ?? "no data").fontWeight(.semibold).foregroundColor(learnBlue)
        //                                    }.padding(.leading,0)
        //                                    Spacer()
        //                                }
        //
        //                        }).buttonStyle(PlainButtonStyle())
                                
                                // custom
                                NavigationLink(destination: ActionDetail(learnin: learn), label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(learnLightBlue).frame(height: 70).shadow(color: learnGray, radius: 1,x:3,y:3)
                                        HStack {
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text(learn.title ?? "no data").fontWeight(.semibold)
                                                Text(((learn.reflect)!.allObjects as! [Reflect]).sorted(by:{$0.id < $1.id})[((learn.reflect)!.allObjects).count-1].action ?? "no data").fontWeight(.semibold).foregroundColor(learnBlue)
                                            }.padding(.leading,30)
                                            Spacer()
                                            Image("Arrow").padding(.trailing,12)
                                        }
                                    }.padding(.horizontal,35)
                                }).buttonStyle(PlainButtonStyle())
                            
                            }.listStyle(SidebarListStyle())
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Action Plan")
                .toolbar {
                    NavigationLink(destination: TitleInput(rootIsActive: self.$isActive),isActive: self.$isActive, label:{
                        Text("+").font(.system(size: 35, weight: .semibold))
                    })
            }
        }
        
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}

//
//  ContentView.swift
//  LearnUp
//
//  Created by Vincentius Ian Widi Nugroho on 24/07/22.
//

import SwiftUI

struct LearnedView: View {
    @Environment(\.managedObjectContext) var moc
        @FetchRequest(sortDescriptors: [SortDescriptor(\.id)],predicate: NSPredicate(format: "status == %@", "learned")) var learneds: FetchedResults<Learn>
    
    var body: some View {
        NavigationView {
            VStack {
                Rectangle().frame(height: 0).background(learnLightBlue)
                if(learneds.count==0){
                    Text("Nothing\nLearned").multilineTextAlignment(.center).foregroundColor(.gray).padding(.top,250)
                }
                else {
                    ScrollView {
                        ForEach(learneds, id: \.id) { learn in
                            // custom
                            NavigationLink(destination: LearnedDetail(learnin: learn), label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(learnLightBlue).frame(height: 45).shadow(color: learnGray, radius: 1,x:3,y:3)
                                    HStack {
                                        VStack(alignment: .leading, spacing: 5) {
                                            HStack {
                                                Text(learn.title ?? "error").fontWeight(.semibold)
                                                Text("(\(((learn.reflect)!.allObjects as! [Reflect]).count))").fontWeight(.semibold)
                                            }
                                        }.padding(.leading,30)
                                        Spacer()
                                        Image("Arrow").padding(.trailing,12)
                                    }
                                }.padding(.horizontal,35)
                            }
                            ).buttonStyle(PlainButtonStyle())
                            
    //                        NavigationLink(destination: LearnedDetail(learnin: learn), label:{
    //                                HStack {
    //                                    VStack(alignment: .leading, spacing: 5) {
    //                                        Text(learn.title ?? "error").fontWeight(.semibold)
    //                                    }.padding(.leading,0)
    //                                    Spacer()
    //                                }
    //
    //                        }).buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Learned")
        }
    }
    
}

struct LearnedView_Previews: PreviewProvider {
    static var previews: some View {
        LearnedView()
    }
}

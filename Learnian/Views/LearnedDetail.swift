//
//  LearnedDetail.swift
//  LearnUp
//
//  Created by Vincentius Ian Widi Nugroho on 25/07/22.
//

import SwiftUI

struct LearnedDetail: View {
    @Environment(\.managedObjectContext) var moc
    @State var learnin: Learn
    private var allReflek: [Reflect]
    private var sortedReflek: [Reflect]

    init(learnin: Learn){
        self.learnin = learnin
        self.allReflek = (learnin.reflect)!.allObjects as! [Reflect]
        self.sortedReflek = allReflek.sorted(by:{$0.id < $1.id})
    }
    
    var body: some View {
        VStack {
            Rectangle().frame(height: 0).background(learnLightBlue)
            List(sortedReflek) { reflek in
                VStack {
                    HStack{
                        ReflectView(reflek:reflek)
                        Spacer()
                    }.padding(.leading,20)
                }
            }

            Spacer()
        }
        .navigationTitle(learnin.title ?? "no title")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func ReflectView(reflek: Reflect) -> AnyView {
        return AnyView(
            VStack(alignment: .leading){
                // action plan
                Text(reflek.action ?? "error loading action").font(.system(size: 20, weight: .semibold)).padding(.top,15)
                
                // www
                Text("What went well:").font(.system(size: 16, weight: .medium)).padding(.top,15)
                Text(reflek.well ?? "no data").font(.system(size: 16, weight: .regular))
                
                // diff
                Text("Difficulties:").font(.system(size: 16, weight: .medium)).padding(.top,15)
                Text(reflek.diff ?? "no data").font(.system(size: 16, weight: .regular))
                
                // Notes
                Text("Notes:").font(.system(size: 16, weight: .medium)).padding(.top,15)
                Text(reflek.notes ?? "no data").font(.system(size: 16, weight: .regular)).padding(.bottom,15)
            }
        )

    }
}

//struct ActionDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ActionDetail()
//    }
//}

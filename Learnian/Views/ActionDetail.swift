//
//  ActionDetail.swift
//  LearnUp
//
//  Created by Vincentius Ian Widi Nugroho on 25/07/22.
//

import SwiftUI

struct ActionDetail: View {
    @Environment(\.managedObjectContext) var moc
    @State var learnin: Learn
    private var reflekCount: Int
    private var allReflek: [Reflect]
    private var sortedReflek: [Reflect]
    private var currReflek: Reflect
    private var prevReflek: Reflect = Reflect()

    init(learnin: Learn){
        self.learnin = learnin
        self.allReflek = (learnin.reflect)!.allObjects as! [Reflect]
        self.sortedReflek = allReflek.sorted(by:{$0.id < $1.id})
        self.reflekCount = allReflek.count
        self.currReflek = sortedReflek[reflekCount-1]
        if(reflekCount>1){
            self.prevReflek = sortedReflek[reflekCount-2]
        }
    }
    
    var body: some View {

        VStack {
            Rectangle().frame(height: 0).background(learnLightBlue)
            HStack{
                prevReflect()
                Spacer()
            }.padding(.leading,20)

            Spacer()
            
            // button done
            NavigationLink(destination: ReflectInput(learnResult: learnin), label:{
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(learnBlue).frame(height:40).padding(.horizontal,20)
                    Text("Next").foregroundColor(.white)
                }
            }).padding()
        }
        .navigationTitle("Action Plan")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func prevReflect() -> AnyView {
        if (reflekCount>=2){
            return AnyView(
                VStack(alignment: .leading){
                    // action plan
                    Text("Action Plan:").font(.system(size: 20, weight: .semibold)).padding(.top,20)
                    Text(currReflek.action ?? "no data").font(.system(size: 16, weight: .medium))
                    
                    Text("Previous Reflection:").font(.system(size: 20, weight: .semibold)).padding(.top,15)
                    // www
                    Text("What went well:").font(.system(size: 16, weight: .medium)).padding(.top,15)
                    Text(prevReflek.well ?? "no data").font(.system(size: 16, weight: .regular))
                    
                    // diff
                    Text("Difficulties:").font(.system(size: 16, weight: .medium)).padding(.top,15)
                    Text(prevReflek.diff ?? "no data").font(.system(size: 16, weight: .regular))
                    
                    // Notes
                    Text("Notes:").font(.system(size: 16, weight: .medium)).padding(.top,15)
                    Text(prevReflek.notes ?? "no data").font(.system(size: 16, weight: .regular))
                }
            )
        } else {
            return AnyView(
                VStack(alignment: .leading){
                    // action plan
                    Text("Action Plan:").font(.system(size: 20, weight: .semibold)).padding(.top,20)
                    Text(currReflek.action ?? "no data").font(.system(size: 16, weight: .medium))
                    Text("No Previous Reflection").font(.system(size: 20, weight: .semibold)).padding(.top,15)
                }
            )
        }

    }
}

//struct ActionDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ActionDetail()
//    }
//}

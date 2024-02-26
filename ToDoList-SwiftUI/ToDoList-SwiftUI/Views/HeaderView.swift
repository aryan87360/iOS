//
//  MainView.swift
//  ToDoList-SwiftUI
//
//  Created by Sillas Santos on 13/06/23.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String
    let subtitle: String
    let angle: Double
    let background: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: angle))
            VStack{
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .bold()
                
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                    .bold()
            }
            .padding(.top, 30)
        }
        .frame(width: UIScreen.main.bounds.width * 3,
               height: 300 )
        .offset(y: -100)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "To Do List", subtitle: "Get Things Done", angle: 15, background: Color.pink)
    }
}

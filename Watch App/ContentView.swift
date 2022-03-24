//
//  ContentView.swift
//  Watch App
//
//  Created by James Armer on 01/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var detail = false
    // initialisation....
    @State var detailData : Watch = data[0]
    
    var body: some View {
       
        ZStack{
            
            Detail(detailData: self.$detailData, detail: self.$detail)
            
            // expanding view whenever detail view is tapped...
                .frame(width: self.detail ? nil : 100, height: self.detail ? nil : 100)
                .opacity(self.detail ? 1 : 0)
            
            // hiding main view when detail view is visible...
            
            Home(detailData: self.$detailData, detail: self.$detail)
                .opacity(self.detail ? 0 : 1)
        }
        .animation(.default)
        // for changing status bar color...
        .preferredColorScheme(self.detail ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var index = "ALL"
    @State var tab = 0
    @Binding var detailData : Watch
    @Binding var detail : Bool
    var bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom

    
    var body: some View{
        
        ZStack{
            
            Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack{
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                    }

                }
                .padding(.vertical)
                
                HStack{
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Welcome!")
                        
                        Text("Discovery")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundColor(.black)
                    }

                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing:25) {
                        
                        // were going to create swipe menu by iteration
                        
                        ForEach(menu, id: \.self){ i in
                            Button {
                                
                                self.index = i
                                
                            } label: {
                                Text(i)
                                    .foregroundColor(self.index == i ? Color("Color1") : Color.black.opacity(0.6))
                                    .fontWeight(.bold)
                            }

                        }
                    }
                    .padding(.horizontal)
                    
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 25){
                        
                        ForEach(data, id: \.self){ i in
                            
                            ZStack(alignment: .bottom) {
                                
                                Color("Color")
                                    .frame(height: UIScreen.main.bounds.height / 3)
                                    .cornerRadius(20)
                                
                                VStack(spacing: 20){
                                    
                                    Image(i.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: UIScreen.main.bounds.width / 1.7)
                                        .onTapGesture {
                                            
                                            // assigning data whenever image is tapped...
                                            self.detailData = i
                                            self.detail.toggle()
                                        }
                                    
                                    HStack{
                                        VStack(alignment: .leading, spacing: 12) {
                                            
                                            Text(i.title)
                                            
                                            Text("Apple Watch")
                                                .fontWeight(.bold)
                                                .font(.title)
                                        }
                                        .foregroundColor(.white)
                                        
                                        Spacer(minLength: 0)
                                        
                                        Button {
                                            print("The \(i.title) has been selected")
                                        } label: {
                                            Image(systemName: "plus")
                                                .font(.callout)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color("Color1"))
                                                .clipShape(Circle())
                                        }

                                    }
                                    
                                    
                                }
                                .padding(.horizontal)
                                .padding(.bottom )
                                
                            }
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 25)
                }
                
                Spacer()
                
                HStack{
                    
                    Button {
                        self.tab = 0
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .font(.title)
                            .foregroundColor(self.tab == 0 ? .black : Color.black.opacity(0.25))
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        self.tab = 1
                    } label: {
                        Image(systemName: "safari")
                            .font(.title)
                            .foregroundColor(self.tab == 1 ? .black : Color.black.opacity(0.25))
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        self.tab = 2
                    } label: {
                        Image(systemName: "person.circle")
                            .font(.title)
                            .foregroundColor(self.tab == 2 ? .black : Color.black.opacity(0.25))
                    }
                    
                    

                }
                .padding(.horizontal, 30)
                .padding(.top, 25)
//                // for no safearea phones padding will be 15 at bottom...
                .padding(.bottom, self.bottom! == 0 ? 15 : self.bottom! + 10)
                .background(Color.white)
                .clipShape(CShape())
                
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
}


struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 45, height: 45))
        
        return Path(path.cgPath)
    }
}

// Detail View...

struct Detail : View {
    
    @State var txt = ""
    @State var index = 0
    // Sample for designing...
    @Binding var detailData : Watch
    @Binding var detail : Bool
    
    var bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom
    
    
    var body: some View{
        
        ZStack{
            
            Color("Color").edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack{
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }

                }
                .padding(.vertical)
                
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
          
                        .foregroundColor(.gray)
                    
                    TextField("Want to search anything", text: self.$txt)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(8)
                .padding(.horizontal)
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text(self.detailData.title)
                        
                        Text("Apple Watch Series 7")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.vertical)
                .padding(.horizontal)
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Color")
                            .foregroundColor(Color.white.opacity(0.6))
                        
                        Text(self.detailData.color)
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.white)
                        
                        Text("Price")
                            .foregroundColor(Color.white.opacity(0.6))
                            .padding(.top)
                        
                        Text(self.detailData.price)
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    // Due to bottom padding...
                    .offset(y: -50)
                    
                    Spacer(minLength: 0)
                    
                    Image(self.detailData.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    // width 2 height 2.5
                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2.5)
                        .rotationEffect(.init(degrees: 10))
                }
                .padding(.horizontal)
                .padding(.bottom, -80) // -60
                .zIndex(5)
                // Z index sets views position on the stack...
                // Moving bottom view up...
                
                
                ZStack(alignment: .topLeading){
                    
                    VStack{
                        
                        
                        // for phones having lesser screen size...
                        
                        ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .init(), showsIndicators: false) {
                           
                            VStack{
                                
                                HStack(spacing: 0) {
                                    
                                    Button {
                                        
                                        self.index = 0
                                        
                                    } label: {
                                        
                                        Text("Details")
                                            .foregroundColor(self.index == 0 ? .white : Color.black.opacity(0.6))
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 25)
                                            .background(self.index == 0 ? Color("Color1") : Color.clear)
                                            .cornerRadius(8)
                                    }
                                    
                                    Button {
                                        self.index = 1
                                        
                                    } label: {
                                        
                                        Text("Description")
                                            .foregroundColor(self.index == 1 ? .white : Color.black.opacity(0.6))
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 25)
                                            .background(self.index == 1 ? Color("Color1") : Color.clear)
                                            .cornerRadius(8)
                                    }
                                    
                                    Spacer()

                                }

                                
                                if self.index == 0 {
                                
                                HStack(spacing: 30) {
                                    
                                    VStack(spacing: 5){
                                        
                                        Text("15mm")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black.opacity(0.8))
                                        
                                        Text("Strap \nWidth")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color.black.opacity(0.4))
                                            
                                        
                                    }
                                    
                                    VStack(spacing: 5){
                                        
                                        Text("Fabric")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black.opacity(0.8))
                                        
                                        Text("Strap \nMaterial")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color.black.opacity(0.4))
                                        
                                    }
                                    
                                    VStack(spacing: 5){
                                        
                                        Text("50m")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black.opacity(0.8))
                                        
                                        Text("Water \nResistance")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color.black.opacity(0.4))
                                            
                                        
                                    }
                                }
                                .padding(.top)
                                .animation(.none)
                                
                                } else {
                                Text("Apple Watch Series 7 is the most durable Apple Watch ever. With a new tougher display and faster charging, Apple Watch Series 7 is ready for anything.")
                                    .foregroundColor(.black)
                                    .padding(.top)
                                    
                                    
                                }
                            }
                            .padding(.horizontal, 25)
                        }
                        // Due to bottom padding -50...
                        .padding(.top, 50)
                        
                        HStack{
                            
                            Button {
                                
                            } label: {
                                Text("Add to Cart")
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width / 1.5)
                                    .background(Color("Color1"))
                                    .cornerRadius(10)
                            }
                            .shadow(radius: 5)
                            
                            Spacer(minLength: 0)
                            
                            Button {
                                
                                // closing the detail view when close button is pressed...
                                self.detail.toggle()
                                
                            } label: {
                                
                                Image(systemName: "xmark")
                                    .font(.title)
                                    .foregroundColor(Color.black.opacity(0.8))
                                    .padding(.horizontal)
                            }


                        }
                        .padding(.top,10)
                        .padding(.horizontal, 25)
                        .padding(.bottom, self.bottom! == 0 ? 15 : self.bottom)
                    }
                    .background(Color.white)
                    .clipShape(CShape())
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Color1"))
                            .clipShape(Circle())
                    }
                    .padding(.leading, 50)
                    .offset(y: -35)

                }
               
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// menu buttons...

var menu = ["ALL","CLASSIC","GRAND","FORMAL","ORIGINAL","TREND"]


// sample watch data ...

struct Watch : Identifiable, Hashable {
    
    var id : Int
    var color : String
    var price : String
    var image : String
    var title : String

}

var data = [

    Watch(id: 0, color: "Charcoal", price: "£500", image: "black", title: "Classic Black"),
    Watch(id: 1, color: "Light Yellow", price: "£450", image: "yellow", title: "Classic Yellow"),
    Watch(id: 2, color: "Pistachio", price: "£510", image: "pistachio", title: "Classic Pistachio"),
    Watch(id: 3, color: "Red", price: "£450", image: "red", title: "Classic Red")
]

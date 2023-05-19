//
//  SheetView.swift
//  Custom-DatePicker
//
//  Created by Vignesh on 19/05/23.
//

import SwiftUI

struct SheetView: View {
    
    @State private var showSheetView = false
    
    @State var selectedDate = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }

    var body: some View {
        
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            LazyVStack(alignment:.leading, spacing: 10) {
                
                HStack{
                    Text("Date Of Birth")
                        .foregroundColor(.gray)
                        .italic()
                    
                    Text("*")
                        .foregroundColor(.red)
                }
                ZStack{
                    
                    Color.white
                    
                    HStack{
                        Text(dateFormatter.string(from: selectedDate))
                            .foregroundColor(.black)
                            .padding(.horizontal,10)
                            .frame(height:44)
                        
                        Spacer()
                        
                        Image(systemName: "calendar")
                            .padding(.horizontal,10)
                            .foregroundColor(.black)
                    }
                }
                .border(Color.gray)
                .onTapGesture {
                    self.showSheetView.toggle()
                }
                .sheet(isPresented: $showSheetView) {
                    Sheet(showSheetView: self.$showSheetView, selectedDate: $selectedDate)
                }
               
            }
            .padding(.horizontal, 10)
        }
    }
}


struct Sheet: View {
    
    @Binding var showSheetView: Bool
    
    @Binding var selectedDate: Date
    
    let startingDate: Date = Calendar.current.date(from:
        DateComponents(year: 1900)) ?? Date()
    let endingDate: Date = Date()
     
    
    var body: some View {
        NavigationView {
            DatePicker("Date of Birth",
                           selection: $selectedDate,
                           in: startingDate...endingDate,
                           displayedComponents: [.date]
                )
                .labelsHidden()
                .accentColor(Color.white)
                .datePickerStyle(
                    WheelDatePickerStyle()
                )
            .navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    print("Dismissing sheet view...")
                    self.showSheetView = false
                }) {
                    Text("Done").bold()
                })
        }
        .presentationDetents([.height(220)])
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}

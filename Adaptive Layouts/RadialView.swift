//
//  RadialView.swift
//  Adaptive Layouts
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

struct RadialView: View {
	
	@State private var currentLayout = 0
	
	var layout: AnyLayout {
		layouts[currentLayout]
	}
	
	let layouts = [
		AnyLayout(VStackLayout()),
		AnyLayout(HStackLayout()),
		AnyLayout(ZStackLayout()),
		AnyLayout(GridLayout()),
		AnyLayout(RadialLayout())
	]
	
    var body: some View {
		VStack {
			Spacer()
			
			layout {
				GridRow {
					ExampleView(color: .red)
					ExampleView(color: .green)
				}
				
				GridRow {
					ExampleView(color: .blue)
					ExampleView(color: .orange)	
				}
				
				GridRow {
					ExampleView(color: .purple)
					ExampleView(color: .pink)
				}
			}
			
			Spacer()
			
			Button("Change Layout") {
				withAnimation { 
					currentLayout += 1
					
					if currentLayout == layouts.count {
						currentLayout = 0
					}
				}
			}
			.buttonStyle(.borderedProminent)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding()
		.background()
    }
}

struct RadialView_Previews: PreviewProvider {
    static var previews: some View {
        RadialView()
    }
}

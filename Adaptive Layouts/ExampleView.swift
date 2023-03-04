//
//  ExampleView.swift
//  Adaptive Layouts
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

struct ExampleView: View {
	
	@State private var counter = 0
	
	let color: Color
	
    var body: some View {
		Button {
			counter += 1
		} label: {
			RoundedRectangle(cornerRadius: 10)
				.fill(color)
				.overlay { 
					Text(String(counter))
						.foregroundColor(.white)
						.font(.largeTitle)
				}
		}
		.frame(width: 100, height: 100)
		.rotationEffect(.degrees(.random(in: -20...20)))
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
		ExampleView(color: .blue)
    }
}

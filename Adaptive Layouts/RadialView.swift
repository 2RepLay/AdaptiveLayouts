//
//  RadialView.swift
//  Adaptive Layouts
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

struct RadialView: View {
	
	@State private var count = 16
	@State private var isExpanded = false
	
    var body: some View {
		RadialLayout(rollOut: isExpanded ? 1 : 0) {
			ForEach(0..<count, id: \.self) { _ in 
				Circle()
					.frame(width: 32, height: 32)
			}
		}
		.safeAreaInset(edge: .bottom) { 
			VStack {
				Stepper("Count: \(count)", value: $count.animation(), in: 0...36)
					.padding()
				
				Button("Expand") {
					withAnimation(.easeInOut(duration: 1)) { 
						isExpanded.toggle()
					}
				}
			}
		}
    }
}

struct RadialView_Previews: PreviewProvider {
    static var previews: some View {
        RadialView()
    }
}

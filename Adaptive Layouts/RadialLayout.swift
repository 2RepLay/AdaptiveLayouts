//
//  RadialLayout.swift
//  Adaptive Layouts
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

struct RadialLayout: Layout {
	
	func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
		proposal.replacingUnspecifiedDimensions()
	}	
	
	func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
		let radius = min(bounds.size.width, bounds.size.height) / 2
		let angle = Angle.degrees(360 / Double(subviews.count)).radians	
		
		for (index, subview) in subviews.enumerated() {
			let viewSize = subview.sizeThatFits(.unspecified)
			let xPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
			let yPos = sin(angle * Double(index) - .pi / 2) * (radius - viewSize.height / 2)
			let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
			
			subview.place(at: point, anchor: .center, proposal: .unspecified)
		}
	}
	
}

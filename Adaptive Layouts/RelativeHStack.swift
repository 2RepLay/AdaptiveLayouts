//
//  RelativeHStack.swift
//  Adaptive Layouts
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

struct RelativeHStack: Layout {
	
	var spacing = 0.0
	
	func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
		let width = proposal.replacingUnspecifiedDimensions().width
		let viewFrames = frames(for: subviews, in: width)
		let height = viewFrames.max { $0.maxY < $1.maxY } ?? .zero
		return CGSize(width: width, height: height.maxY)
	}
	
	func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
		let viewFrames = frames(for: subviews, in: bounds.width)
		
		for index in subviews.indices {
			let frame = viewFrames[index]
			let position = CGPoint(x: bounds.minX + frame.minX, y: bounds.midY)
			subviews[index].place(
				at: position, 
				anchor: .leading, 
				proposal: ProposedViewSize(frame.size)
			)
		}
	}
	
	func frames(for subviews: Subviews, in totalWidth: Double) -> [CGRect] {
		let totalSpacing = spacing * Double(subviews.count - 1)
		let availableWidth = totalWidth - totalSpacing
		let totalPriorities = subviews.reduce(0) {
			$0 + $1.priority
		}
		var viewFrames = [CGRect]()
		var x = 0.0
		
		for subview in subviews {
			let subviewWidth = availableWidth * subview.priority / totalPriorities
			let proposal = ProposedViewSize(width: subviewWidth, height: nil)
			let size = subview.sizeThatFits(proposal)
			let frame = CGRect(x: x, y: 0, width: size.width, height: size.height)
			viewFrames.append(frame)
			x += size.width + spacing
		}
		
		return viewFrames
	}
	
}

struct RelativeHStack_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			RelativeHStack(spacing: 50) {
				Text("First")
					.frame(maxWidth: .infinity)
					.background(.red)
					.layoutPriority(4)
				
				Text("Second")
					.frame(maxWidth: .infinity)
					.background(.green)
					.layoutPriority(4)
				
				Text("Third")
					.frame(maxWidth: .infinity)
					.background(.blue)
					.layoutPriority(12)
			}
		}
    }
}

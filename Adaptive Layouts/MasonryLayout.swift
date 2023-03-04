//
//  MasonryLayout.swift
//  Adaptive Layouts
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

struct MasonryLayout: Layout {
	
	struct Cache {
		var frames: [CGRect]
		var width = 0.0
	}

	var columns: Int
	var spacing: Double
	
	init(columns: Int = 3, spacing: Double = 5) {
		self.columns = max(1, columns)
		self.spacing = spacing
	}
	
	func makeCache(subviews: Subviews) -> Cache {
		Cache(frames: [])
	}
	
	func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
		
		let width = proposal.replacingUnspecifiedDimensions().width
		let viewFrames = frames(for: subviews, in: width)
		let height = viewFrames.max { $0.maxY < $1.maxY } ?? .zero
		
		cache.frames = viewFrames
		cache.width = width
		return CGSize(width: width, height: height.maxY)
	}
	
	func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
		
		if cache.width != bounds.width {
			cache.frames = frames(for: subviews, in: bounds.width)
			cache.width = bounds.width
		}
		
		for index in subviews.indices {
			let frame = cache.frames[index]
			let position = CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY)
			subviews[index].place(
				at: position,  
				proposal: ProposedViewSize(frame.size)
			)
		}
	}
	
	func frames(for subviews: Subviews, in totalWidth: Double) -> [CGRect] {
		let totalSpacing = spacing * Double(columns - 1)
		let columnWidth = (totalWidth - totalSpacing) / Double(columns)
		let columnWidthWithSpacing = columnWidth + spacing
		let proposedSize = ProposedViewSize(width: columnWidth, height: nil)
		
		var viewFrames = [CGRect]()
		var columnHeights = Array(repeating: 0.0, count: columns)
		
		for subview in subviews {
			var selectedColumn = 0
			var selectedHeight = Double.greatestFiniteMagnitude
			
			for (columnIndex, height) in columnHeights.enumerated() {
				if height < selectedHeight {
					selectedColumn = columnIndex
					selectedHeight = height
				}
			}
			
			let x = Double(selectedColumn) * columnWidthWithSpacing
			let y = columnHeights[selectedColumn]
			
			let size = subview.sizeThatFits(proposedSize)
			let frame = CGRect(
				x: x, 
				y: y, 
				width: size.width, 
				height: size.height
			)
			
			columnHeights[selectedColumn] += size.height + spacing
			viewFrames.append(frame)
		}
		
		return viewFrames	
	}
	
}

struct PlaceholderView: View {
	
	let color: Color = [.blue, .cyan, .green, .indigo, .mint, .orange, .pink, .purple, .red].randomElement()!
	
	let size: CGSize
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 10)
				.fill(color)
			
			Text("\(Int(size.width))x\(Int(size.height))")
				.foregroundColor(.white)
				.font(.headline)
		}
		.aspectRatio(size, contentMode: .fill)
	}
	
}

struct MasonryLayout_Previews: PreviewProvider {
    static var previews: some View {
		MasonryLayout {
			Text("Hello, World!")
		}
    }
}

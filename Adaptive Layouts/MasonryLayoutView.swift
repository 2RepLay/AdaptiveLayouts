//
//  MasonryLayoutView.swift
//  Adaptive Layouts
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

struct MasonryLayoutView: View {
	
	@State private var columns = 3
	
	@State private var views = (0..<20).map { _ in
		CGSize(width: .random(in: 100...500), height: .random(in: 100...500))
	}
	
    var body: some View {
		ScrollView { 
			MasonryLayout(columns: columns) {
				ForEach(0..<20) { i in
					PlaceholderView(size: views[i])
				}
			}
			.padding(5)
		}
		.safeAreaInset(edge: .bottom) {
			Stepper("Columns: \(columns)", value: $columns.animation(), in: 1...5)
				.padding()
				.background(.regularMaterial)
		}
    }
}

struct MasonryLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        MasonryLayoutView()
    }
}

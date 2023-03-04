//
//  EqualWidthHStackView.swift
//  Adaptive Layouts
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

struct EqualWidthHStackView: View {
    var body: some View {
		EqualWidthHStack {
			Text("Short")
				.background(.red)
			
			Text("This is long")
				.background(.green)
			
			Text("This is longest")
				.background(.blue)
		}
    }
}

struct EqualWidthHStackView_Previews: PreviewProvider {
    static var previews: some View {
        EqualWidthHStackView()
    }
}

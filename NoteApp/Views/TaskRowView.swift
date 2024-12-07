//
//  Created by Maximar Yepez on 12/4/24.
//

import SwiftUI

struct TaskRowView: View {
    var task: Task

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(task.title)
                .font(.headline)
            Text(task.content)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .padding(.vertical, 8)
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: Task(title: "Task", content: "This is a sample task content."))
            .previewLayout(.sizeThatFits)
    }
}

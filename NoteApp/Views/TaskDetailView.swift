//
//
//  Created by Maximar Yepez on 12/4/24.
//

import SwiftUI

struct TaskDetailView: View {
    var task: Task
    @ObservedObject var viewModel: TaskViewModel
    @Environment(\.dismiss) var dismiss

    @State private var isEditing: Bool = false
    @State private var editedTitle: String = ""
    @State private var editedContent: String = ""
    @State private var showingDeleteAlert: Bool = false
    @State private var showingCompleteAlert: Bool = false
    @State private var isCompleting: Bool = false


    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if isEditing {
                TextField("Title", text: $editedTitle)
                    .font(.headline)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextEditor(text: $editedContent)
                    .font(.body)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .frame(height: 200)
            } else {
                Text(task.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(task.content)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Task Detail")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if isEditing {
                    Button("Save") {
                        let trimmedTitle = editedTitle.trimmingCharacters(in: .whitespaces)
                        if !trimmedTitle.isEmpty {
                            viewModel.updateTasks(task: task, title: trimmedTitle, content: editedContent)
                            isEditing = false
                        }
                    }
                    .disabled(editedTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                    
                    Button("Cancel") {
                        isEditing = false
                    }
                    
                } else if isCompleting {
                    
                   Button("Save") {
                        let trimmedTitle = editedTitle.trimmingCharacters(in: .whitespaces)
                        if !trimmedTitle.isEmpty {
                            viewModel.completeTasks(task: task, title: trimmedTitle, content: "COMPLETADO!!!")
                            isCompleting = false
                        }
                    }
                    .disabled(editedTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                    
                    Button("Cancel") {
                        isCompleting = false
                    }
                    
                } else {
                    Button("Edit") {
                        editedTitle = task.title
                        editedContent = task.content
                        isEditing = true
                    }
                    
                    Button("Complete") {
                        editedTitle = task.title
                        isCompleting = true
                    }
                    
                    Button(action: {
                        showingDeleteAlert = true
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete Task"),
                message: Text("Are you sure you want to delete this task?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                        viewModel.deleteTask(at: IndexSet(integer: index))
                        dismiss()
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: Task(title: "Sample Task", content: "This is a sample task content."), viewModel: TaskViewModel())
    }
}

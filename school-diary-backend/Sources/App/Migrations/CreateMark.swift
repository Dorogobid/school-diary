import Fluent
import Vapor

extension Mark {
    struct Migration: AsyncMigration {
        var name: String { "CreateMark" }
        
        func prepare(on database: Database) async throws {
            try await database.schema("marks")
                .id()
                .field("mark_date", .string, .required)
                .field("subject_id", .uuid, .references("subjects", "id"))
                .field("student_id", .uuid, .references("students", "id"))
                .field("teacher_id", .uuid, .references("teachers", "id"))
                .field("mark", .int, .required)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema("marks").delete()
        }
        
    }
}

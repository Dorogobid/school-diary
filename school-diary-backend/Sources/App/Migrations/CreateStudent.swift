import Fluent
import Vapor

extension Student {
    struct Migration: AsyncMigration {
        var name: String { "CreateStudent" }
        
        func prepare(on database: Database) async throws {
            try await database.schema("students")
                .id()
                .field("name", .string, .required)
                .field("photo", .string)
                .field("login", .string, .required)
                .field("password", .string, .required)
                .field("date_of_birth", .date, .required)
                .field("school_class_id", .uuid, .references("school_classes", "id"))
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema("students").delete()
        }
        
    }
}

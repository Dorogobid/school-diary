import Fluent
import Vapor

extension Subject {
    struct Migration: AsyncMigration {
        var name: String { "CreateSubject" }
        
        func prepare(on database: Database) async throws {
            try await database.schema("subjects")
                .id()
                .field("subject_name", .string, .required)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema("subjects").delete()
        }
        
    }
}

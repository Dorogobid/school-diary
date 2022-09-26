import Fluent
import Vapor

extension Teacher {
    struct Migration: AsyncMigration {
        var name: String { "CreateTeacher" }
        
        func prepare(on database: Database) async throws {
            try await database.schema("teachers")
                .id()
                .field("name", .string, .required)
                .field("photo", .string)
                .field("login", .string, .required)
                .field("password", .string, .required)
                .field("date_of_birth", .date, .required)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema("teachers").delete()
        }
        
    }
}

import Fluent
import Vapor

extension SchoolClass {
    struct Migration: AsyncMigration {
        var name: String { "CreateSchoolClass" }
        
        func prepare(on database: Database) async throws {
            try await database.schema("school_classes")
                .id()
                .field("class_name", .string, .required)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema("school_classes").delete()
        }
        
    }
}

import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    app.migrations.add(Subject.Migration())
    app.migrations.add(SchoolClass.Migration())
    app.migrations.add(Student.Migration())
    app.migrations.add(Teacher.Migration())
    app.migrations.add(Mark.Migration())

    app.views.use(.leaf)
//    app.passwords.use(.bcrypt)

    app.logger.logLevel = .debug

    // register routes
    try routes(app)
}

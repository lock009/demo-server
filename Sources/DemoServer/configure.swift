import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    if let databaseURL = Environment.get("DATABASE_URL") {
            // Render production database
            try app.databases.use(.postgres(url: databaseURL), as: .psql)
        } else {
            // Local development fallback
            app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
                hostname: Environment.get("DATABASE_HOST") ?? "localhost",
                port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 5432,
                username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
                password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
                database: Environment.get("DATABASE_NAME") ?? "vapor_database",
                tls: .disable
            )), as: .psql)
        }

        // MARK: - Migrations

        app.migrations.add(CreateUserTableMigrations())
        try await app.autoMigrate()

        // MARK: - JWT

    await app.jwt.keys.add(hmac: "secretkey", digestAlgorithm: .sha256)

        try app.register(collection: UserController())
        try routes(app)
}

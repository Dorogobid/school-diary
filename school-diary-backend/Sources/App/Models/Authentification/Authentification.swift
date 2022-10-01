import Vapor

struct ApiUser: Authenticatable {
    var name: String
}

struct UserAuthenticator: AsyncBearerAuthenticator {
    typealias ApiUser = App.ApiUser

    func authenticate(
        bearer: BearerAuthorization,
        for request: Request
    ) async throws {
        if bearer.token == "eyJhbGciOiJQUzI1NiIsInR5cCI6IkpXVCJ98Ng09a8" {
            request.auth.login(ApiUser(name: "MobileApp"))
        }
   }
}

//
//  Database+RoleManagement.swift
//  MongoKitten
//
//  Created by Laurent Gaches on 28/12/2016.
//
//

import Foundation

extension Database {
    
    /// Grants roles to a user in this database
    ///
    /// For additional information: https://docs.mongodb.com/manual/reference/command/grantRolesToUser/#dbcmd.grantRolesToUser
    ///
    /// - parameter roles: The roles to grants
    /// - parameter user: The user's username to grant the roles to
    ///
    /// - throws: When we can't send the request/receive the response, you don't have sufficient permissions or an error occurred
    public func grant(roles roleList: Document, to user: String) throws {
        let command: Document = [
            "grantRolesToUser": user,
            "roles": roleList
        ]

        let document = try firstDocument(in: try execute(command: command))

        guard document["ok"] as Int? == 1 else {
            logger.error("grantRolesToUser for user \"\(user)\" was not successful because of the following error")
            logger.error(document)
            logger.error("grantRolesToUser failed with the following roles")
            logger.error(roleList)
            throw MongoError.commandFailure(error: document)
        }
    }
}

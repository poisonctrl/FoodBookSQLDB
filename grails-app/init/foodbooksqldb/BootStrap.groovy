package foodbooksqldb

import foodbooksqldb.*
import grails.util.Environment


class BootStrap {

    def init = { servletContext ->
        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        switch (Environment.current) {
            case Environment.DEVELOPMENT:

                def admin = new User(username: "admin", password: "admin", enabled: true).save(flush: true)
                UserRole.create(admin, adminRole).save()
                UserRole.create(admin, userRole).save()

                def user = new User(username: "user", password: "user", enabled: true).save(flush: true)
                UserRole.create(user, userRole).save()

                break
            case Environment.PRODUCTION:
                break
        }

    }
    def destroy = {
    }
}

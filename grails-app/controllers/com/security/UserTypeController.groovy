package com.security

import org.springframework.dao.DataIntegrityViolationException

class UserTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userTypeInstanceList: UserType.list(params), userTypeInstanceTotal: UserType.count()]
    }

    def create() {
        [userTypeInstance: new UserType(params)]
    }

    def save() {
        def userTypeInstance = new UserType(params)
        if (!userTypeInstance.save(flush: true)) {
            render(view: "create", model: [userTypeInstance: userTypeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'userType.label', default: 'UserType'), userTypeInstance.id])
        redirect(action: "show", id: userTypeInstance.id)
    }

    def show(Long id) {
        def userTypeInstance = UserType.get(id)
        if (!userTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userType.label', default: 'UserType'), id])
            redirect(action: "list")
            return
        }

        [userTypeInstance: userTypeInstance]
    }

    def edit(Long id) {
        def userTypeInstance = UserType.get(id)
        if (!userTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userType.label', default: 'UserType'), id])
            redirect(action: "list")
            return
        }

        [userTypeInstance: userTypeInstance]
    }

    def update(Long id, Long version) {
        def userTypeInstance = UserType.get(id)
        if (!userTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userType.label', default: 'UserType'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userTypeInstance.version > version) {
                userTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'userType.label', default: 'UserType')] as Object[],
                          "Another user has updated this UserType while you were editing")
                render(view: "edit", model: [userTypeInstance: userTypeInstance])
                return
            }
        }

        userTypeInstance.properties = params

        if (!userTypeInstance.save(flush: true)) {
            render(view: "edit", model: [userTypeInstance: userTypeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'userType.label', default: 'UserType'), userTypeInstance.id])
        redirect(action: "show", id: userTypeInstance.id)
    }

    def delete(Long id) {
        def userTypeInstance = UserType.get(id)
        if (!userTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userType.label', default: 'UserType'), id])
            redirect(action: "list")
            return
        }

        try {
            userTypeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'userType.label', default: 'UserType'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userType.label', default: 'UserType'), id])
            redirect(action: "show", id: id)
        }
    }
}

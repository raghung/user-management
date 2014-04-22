package com.security

import org.springframework.dao.DataIntegrityViolationException

class ModulesController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [modulesInstanceList: Modules.list(params), modulesInstanceTotal: Modules.count()]
    }

    def create() {
        [modulesInstance: new Modules(params)]
    }

    def save() {
        def modulesInstance = new Modules(params)
        if (!modulesInstance.save(flush: true)) {
            render(view: "create", model: [modulesInstance: modulesInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'modules.label', default: 'Modules'), modulesInstance.id])
        redirect(action: "show", id: modulesInstance.id)
    }

    def show(Long id) {
        def modulesInstance = Modules.get(id)
        if (!modulesInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'modules.label', default: 'Modules'), id])
            redirect(action: "list")
            return
        }

        [modulesInstance: modulesInstance]
    }

    def edit(Long id) {
        def modulesInstance = Modules.get(id)
        if (!modulesInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'modules.label', default: 'Modules'), id])
            redirect(action: "list")
            return
        }

        [modulesInstance: modulesInstance]
    }

    def update(Long id, Long version) {
        def modulesInstance = Modules.get(id)
        if (!modulesInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'modules.label', default: 'Modules'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (modulesInstance.version > version) {
                modulesInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'modules.label', default: 'Modules')] as Object[],
                          "Another user has updated this Modules while you were editing")
                render(view: "edit", model: [modulesInstance: modulesInstance])
                return
            }
        }

        modulesInstance.properties = params

        if (!modulesInstance.save(flush: true)) {
            render(view: "edit", model: [modulesInstance: modulesInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'modules.label', default: 'Modules'), modulesInstance.id])
        redirect(action: "show", id: modulesInstance.id)
    }

    def delete(Long id) {
        def modulesInstance = Modules.get(id)
        if (!modulesInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'modules.label', default: 'Modules'), id])
            redirect(action: "list")
            return
        }

        try {
            modulesInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'modules.label', default: 'Modules'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'modules.label', default: 'Modules'), id])
            redirect(action: "show", id: id)
        }
    }
}

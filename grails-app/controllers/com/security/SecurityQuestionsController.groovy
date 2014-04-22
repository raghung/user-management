package com.security

import org.springframework.dao.DataIntegrityViolationException

class SecurityQuestionsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [securityQuestionsInstanceList: SecurityQuestions.list(params), securityQuestionsInstanceTotal: SecurityQuestions.count()]
    }

    def create() {
        [securityQuestionsInstance: new SecurityQuestions(params)]
    }

    def save() {
        def securityQuestionsInstance = new SecurityQuestions(params)
        if (!securityQuestionsInstance.save(flush: true)) {
            render(view: "create", model: [securityQuestionsInstance: securityQuestionsInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'securityQuestions.label', default: 'SecurityQuestions'), securityQuestionsInstance.id])
        redirect(action: "show", id: securityQuestionsInstance.id)
    }

    def show(Long id) {
        def securityQuestionsInstance = SecurityQuestions.get(id)
        if (!securityQuestionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'securityQuestions.label', default: 'SecurityQuestions'), id])
            redirect(action: "list")
            return
        }

        [securityQuestionsInstance: securityQuestionsInstance]
    }

    def edit(Long id) {
        def securityQuestionsInstance = SecurityQuestions.get(id)
        if (!securityQuestionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'securityQuestions.label', default: 'SecurityQuestions'), id])
            redirect(action: "list")
            return
        }

        [securityQuestionsInstance: securityQuestionsInstance]
    }

    def update(Long id, Long version) {
        def securityQuestionsInstance = SecurityQuestions.get(id)
        if (!securityQuestionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'securityQuestions.label', default: 'SecurityQuestions'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (securityQuestionsInstance.version > version) {
                securityQuestionsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'securityQuestions.label', default: 'SecurityQuestions')] as Object[],
                          "Another user has updated this SecurityQuestions while you were editing")
                render(view: "edit", model: [securityQuestionsInstance: securityQuestionsInstance])
                return
            }
        }

        securityQuestionsInstance.properties = params

        if (!securityQuestionsInstance.save(flush: true)) {
            render(view: "edit", model: [securityQuestionsInstance: securityQuestionsInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'securityQuestions.label', default: 'SecurityQuestions'), securityQuestionsInstance.id])
        redirect(action: "show", id: securityQuestionsInstance.id)
    }

    def delete(Long id) {
        def securityQuestionsInstance = SecurityQuestions.get(id)
        if (!securityQuestionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'securityQuestions.label', default: 'SecurityQuestions'), id])
            redirect(action: "list")
            return
        }

        try {
            securityQuestionsInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'securityQuestions.label', default: 'SecurityQuestions'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'securityQuestions.label', default: 'SecurityQuestions'), id])
            redirect(action: "show", id: id)
        }
    }
}

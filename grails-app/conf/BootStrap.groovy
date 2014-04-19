import com.security.Requestmap;
import com.security.Role;
import com.security.User;
import com.security.UserRole;

class BootStrap {

    def init = { servletContext ->
		def adminRole = Role.findByAuthority("ROLE_ADMIN")?: new Role(authority: 'ROLE_ADMIN').save(flush: true)
		def doctorRole = Role.findByAuthority("ROLE_DOCTOR")?: new Role(authority: 'ROLE_DOCTOR').save(flush: true)
		def staffRole = Role.findByAuthority("ROLE_STAFF")?: new Role(authority: 'ROLE_STAFF').save(flush: true)
		def patientRole = Role.findByAuthority("ROLE_PATIENT")?: new Role(authority: 'ROLE_PATIENT').save(flush: true)
  
		def testUser = new User(username: 'admin', password: 'admin').save(flush: true)
		def testUser1 = new User(username: 'doctor', password: 'doctor').save(flush: true)
		def testUser2 = new User(username: 'staff', password: 'staff').save(flush: true)
		def testUser3 = new User(username: 'patient', password: 'patient').save(flush: true)
  
		UserRole.create testUser, adminRole, true
		UserRole.create testUser1, doctorRole, true
		UserRole.create testUser2, staffRole, true
		UserRole.create testUser3, patientRole, true
  
		assert User.count() == 4
		assert Role.count() == 4
		assert UserRole.count() == 4
		
		for (String url in [
			'/',
			'/index',
			'/index.gsp',
			'/**/favicon.ico',
			'/**/js/**',
			'/**/css/**',
			'/**/images/**',
			'/login',
			'/login.*',
			'/login/*',
			'/logout',
			'/logout.*',
			'/logout/*',
			'/register/**'
		]) {
			new Requestmap(url: url, configAttribute: 'permitAll').save(flush: true)
		}
		new Requestmap(url: '/', configAttribute: 'ROLE_ADMIN, ROLE_DOCTOR').save(flush: true)
		new Requestmap(url: '/user/**', configAttribute: 'ROLE_ADMIN, ROLE_DOCTOR').save(flush: true)
		new Requestmap(url: '/user/create', configAttribute: 'ROLE_ADMIN').save(flush: true)
		new Requestmap(url: '/user/edit', configAttribute: 'ROLE_ADMIN').save(flush: true)
		new Requestmap(url: '/securityInfo/config', configAttribute: 'ROLE_ADMIN').save(flush: true)
		new Requestmap(url: '/persistentLogin/**', configAttribute: 'ROLE_ADMIN').save(flush: true)
		new Requestmap(url: '/role/**', configAttribute: 'ROLE_ADMIN, ROLE_DOCTOR').save(flush: true)
		new Requestmap(url: '/role/create', configAttribute: 'ROLE_ADMIN').save(flush: true)
		new Requestmap(url: '/role/edit', configAttribute: 'ROLE_ADMIN').save(flush: true)
		new Requestmap(url: '/requestmap/**', configAttribute: 'ROLE_ADMIN').save(flush: true)
		
    }
    def destroy = {
    }
}

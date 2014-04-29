import com.security.Organization;
import com.security.Requestmap;
import com.security.Role;
import com.security.User;
import com.security.UserRole;
import com.security.UserType;

class BootStrap {

    def init = { servletContext ->
		def adminRole = Role.findByAuthority("ROLE_ADMIN")?: new Role(authority: 'ROLE_ADMIN').save(flush: true)
		def doctorRole = Role.findByAuthority("ROLE_DOCTOR")?: new Role(authority: 'ROLE_DOCTOR').save(flush: true)
		def staffRole = Role.findByAuthority("ROLE_STAFF")?: new Role(authority: 'ROLE_STAFF').save(flush: true)
		def patientRole = Role.findByAuthority("ROLE_PATIENT")?: new Role(authority: 'ROLE_PATIENT').save(flush: true)
  
		def testUser = new User(username: 'admin@onehaystack.com', password: 'admin', 
								firstname: 'Roger', lastname: 'Federer', type: 'Admin',
								birthDate: new GregorianCalendar(1981, 4, 13).getTime(),
								identification: '123121234', createUser: 1, lastUpdtUser: 1).save(flush: true, failOnError: true)
		def testUser1 = new User(username: 'doctor@onehaystack.com', password: 'doctor',
									firstname: 'Rafael', lastname: 'Nadal', type: 'Doctor',
									birthDate: new GregorianCalendar(1983, 8, 22).getTime(),
									identification: '23456789', createUser: 1, lastUpdtUser: 1).save(flush: true, failOnError: true)
		/*def testUser1 = new User(username: 'doctor', password: 'doctor', type: 'doctor').save(flush: true)
		def testUser2 = new User(username: 'staff', password: 'staff', type: 'staff').save(flush: true)
		def testUser3 = new User(username: 'patient', password: 'patient', type: 'patient').save(flush: true)*/
  
		UserRole.create testUser, adminRole, true
		UserRole.create testUser1, doctorRole, true
		/*UserRole.create testUser1, doctorRole, true
		UserRole.create testUser2, staffRole, true
		UserRole.create testUser3, patientRole, true*/
  
		assert User.count() == 2
		assert Role.count() == 4
		assert UserRole.count() == 2
		
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
		new Requestmap(url: '/modules/**', configAttribute: 'ROLE_ADMIN').save(flush: true)
		new Requestmap(url: '/functions/**', configAttribute: 'ROLE_ADMIN').save(flush: true)
		new Requestmap(url: '/userType/**', configAttribute: 'ROLE_ADMIN').save(flush: true)
		new Requestmap(url: '/securityQuestions/**', configAttribute: 'ROLE_ADMIN').save(flush: true)
		new Requestmap(url: '/organization/**', configAttribute: 'ROLE_ADMIN').save(flush: true)
		
		new UserType(name: 'Admin', description: 'Admin').save(flush: true, failOnError: true)
		new UserType(name: 'Patient', description: 'Patient').save(flush: true, failOnError: true)
		new UserType(name: 'Doctor', description: 'Physician or Higher').save(flush: true, failOnError: true)
		new UserType(name: 'Staff', description: 'People working for Physician').save(flush: true, failOnError: true)
		
		new Organization(name: 'USC', groupName: 'USC KEKH').save(flush: true, failOnError: true)
		new Organization(name: 'USC', groupName: 'USC Cancer').save(flush: true, failOnError: true)
		new Organization(name: 'USC', groupName: 'USC Dermatology').save(flush: true, failOnError: true)
    }
    def destroy = {
    }
}

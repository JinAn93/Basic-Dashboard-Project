package com.fasoo.spring.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;

@Entity
@Table(name = "USERS")
public class User {

	@Id
	@Size(min = 3, max = 30)
	@Column(name = "USER_ID", unique = true, nullable = false)
	private String user_id;

	@NotNull
	@Pattern.List({
	    @Pattern(regexp = "(?=.*[0-9]).+", message = "Password must contain one digit."),
	    @Pattern(regexp = "(?=.*[a-z]).+", message = "Password must contain one lowercase letter."),
	    @Pattern(regexp = "(?=.*[a-z]).+", message = "Password must contain one upper letter."),
	    @Pattern(regexp = "(?=.*[!@#$%^&*+=?-_()/\"\\.,<>~`;:]).+", message ="Password must contain one special character."),
	    @Pattern(regexp = "(?=\\S+$).+", message = "Password must contain no whitespace.")
	})
	@Size(min = 6, max = 15)
	@Column(name = "PASSWORD", nullable = false) 	
	private String password;

	@NotNull
	@Size(max = 50)
	@Column(name = "NAME", nullable = false)
	private String name;

	@NotNull
	@Email
	@Size(max = 100)
	@Column(name = "EMAIL", nullable = false)
	private String email;

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
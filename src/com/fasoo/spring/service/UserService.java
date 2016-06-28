package com.fasoo.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasoo.spring.dao.IUserDao;
import com.fasoo.spring.model.User;

@Service("userService")
@Transactional
public class UserService implements IUserService {

	@Autowired
	private IUserDao dao;

	public User findById(String id) {
		return dao.findById(id);
	}

	public void saveUser(User user) {
		dao.saveUser(user);
	}

	public void updateUser(User user) {
		User entity = dao.findById(user.getUser_id());
		if (entity != null) {
			entity.setName(user.getName());
			entity.setEmail(user.getEmail());
			entity.setPassword(user.getPassword());
		}
	}

	@Override
	public void deleteUserById(String id) {
		dao.deleteUserById(id);
	}

	@Override
	public List<User> findAllUsers() {
		return dao.findAllUsers();
	}

	@Override
	public boolean isUserIdUnique(String user_id) {
		List<User> allUsers = findAllUsers();
		for (User user : allUsers) {
			if (user.getUser_id().equals(user_id))
				return false;
		}
		return true;
	}
}

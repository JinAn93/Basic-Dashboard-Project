package com.fasoo.spring.controller;

import java.util.List;
import java.util.Locale;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasoo.spring.model.Post;
import com.fasoo.spring.model.User;
import com.fasoo.spring.service.IPostService;
import com.fasoo.spring.service.IUserService;

@Controller
@RequestMapping("/")
public class AppController {

	@Autowired
	IPostService postService;

	@Autowired
	IUserService userService;

	@Autowired
	MessageSource messageSource;

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String listPosts(ModelMap model) {
		List<Post> posts = postService.findAllPosts();
		model.addAttribute("posts", posts);
		return "dashboard";
	}

	@RequestMapping(value = { "/", "/login" }, method = RequestMethod.GET)
	public String loginPage(ModelMap model) {
		return "loginPage";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(ModelMap model) {
		return "logout";
	}

	@RequestMapping(value = "/validate", method = RequestMethod.GET)
	public String loginAttempt(ModelMap model) {
		return "validate";
	}

	@RequestMapping(value = "/newPost", method = RequestMethod.GET)
	public String newPost(ModelMap model) {
		Post post = new Post();
		model.addAttribute("post", post);
		return "newPost";
	}

	@RequestMapping(value = "/newPost", method = RequestMethod.POST)
	public String savePost(@Valid Post post, BindingResult result, ModelMap model) {
		if (result.hasErrors()) {
			return "newPost";
		}
		postService.savePost(post);
		return "successPost";
	}

	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String newUser(ModelMap model) {
		User user = new User();
		model.addAttribute("user", user);
		return "registration";
	}

	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public String saveUser(@Valid User user, BindingResult result, ModelMap model) {

		if (result.hasErrors()) {
			return "registration";
		}

		if (!userService.isUserIdUnique(user.getUser_id())) {
			FieldError userIdError = new FieldError("user", "user_id",
					messageSource.getMessage("non.unique.user_id",
							new String[] { user.getUser_id() },
							Locale.getDefault()));
			result.addError(userIdError);
			return "registration";
		}

		// More Validity Checks here (email format, password)

		userService.saveUser(user);
		return "success";
	}
}

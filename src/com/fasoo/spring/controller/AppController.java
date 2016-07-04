package com.fasoo.spring.controller;

import java.util.Locale;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.fasoo.spring.model.Post;
import com.fasoo.spring.model.Reply;
import com.fasoo.spring.model.User;
import com.fasoo.spring.service.IPostService;
import com.fasoo.spring.service.IReplyService;
import com.fasoo.spring.service.IUserService;

@Controller
@RequestMapping("/")
@SessionAttributes("user_id")
public class AppController {

	@Autowired
	IPostService postService;

	@Autowired
	IUserService userService;

	@Autowired
	IReplyService replyService;

	@Autowired
	MessageSource messageSource;

	@RequestMapping(value = { "/", "/login" }, method = RequestMethod.GET)
	public String loginPage(ModelMap model) {
		if (model.containsAttribute("user_id"))
			return "redirect:/dashboard";
		return "loginPage";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(ModelMap model) {
		if (model.containsAttribute("user_id"))
			return "logout";
		return "redirect:/login";
	}

	@RequestMapping(value = "/new", method = RequestMethod.GET)
	public String newUser(ModelMap model) {
		model.addAttribute("user", new User());
		model.addAttribute("edit", false);
		return "registration";
	}

	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public String saveUser(@Valid User user, BindingResult result, ModelMap model) {

		if (result.hasErrors()) {
			return "registration";
		}

		if (!userService.isUserIdUnique(user.getUser_id())) {
			FieldError userIdError = new FieldError("user", "user_id", messageSource.getMessage("non.unique.user_id", new String[] { user.getUser_id() }, Locale.getDefault()));
			result.addError(userIdError);
			return "registration";
		}

		userService.saveUser(user);
		model.addAttribute("success", "New account has been created");
		return "success";
	}

	@RequestMapping(value = { "/edit-{user_id}-user" }, method = RequestMethod.GET)
	public String editUser(@PathVariable String user_id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			User user = userService.findById(user_id);
			model.addAttribute("user", user);
			model.addAttribute("edit", true);
			return "registration";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = { "/edit-{user_id}-user" }, method = RequestMethod.POST)
	public String updateUser(@Valid User user, BindingResult result,
			ModelMap model, @PathVariable String user_id) {
		if (result.hasErrors()) {
			return "registration";
		}

		userService.updateUser(user);
		model.addAttribute("success",
				"Your account has been successfully modified");
		return "success";
	}

	@RequestMapping(value = "/validate", method = RequestMethod.GET)
	public String loginAttempt(ModelMap model) {
		return "validate";
	}

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String listPosts(ModelMap model) {
		if (model.containsAttribute("user_id")) {
			model.addAttribute("posts", postService.findAllPosts());
			return "dashboard";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = "/newPost", method = RequestMethod.GET)
	public String newPost(ModelMap model) {
		if (model.containsAttribute("user_id")) {
			model.addAttribute("post", new Post());
			return "newPost";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = "/newPost", method = RequestMethod.POST)
	public String savePost(@Valid Post post, BindingResult result, ModelMap model) {
		if (result.hasErrors()) {
			return "newPost";
		}
		postService.savePost(post);
		model.addAttribute("success", "New Post has been saved!");
		return "success";
	}
	
	@RequestMapping(value = { "/view-{post_id}-post" }, method = RequestMethod.GET)
	public String viewPost(@PathVariable int post_id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			postService.setCurrentPost(postService.findById(post_id));
			postService.setCurrentPostID(post_id);
			replyService.setStatus(0);

			return "redirect:/detailedPost";
		}
		return "redirect:/login";
	}
	
	@RequestMapping(value = { "/edit-{id}-post" }, method = RequestMethod.GET)
	public String editPost(@PathVariable int id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			model.addAttribute("post", postService.findById(id));
			model.addAttribute("edit", true);
			return "newPost";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = { "/edit-{id}-post" }, method = RequestMethod.POST)
	public String updatePost(@Valid Post post, BindingResult result, ModelMap model, @PathVariable int id) {
		if (result.hasErrors()) {
			return "newPost";
		}

		postService.updatePost(post);
		model.addAttribute("success", "The post has been successfully editted");
		return "success";
	}

	@RequestMapping(value = { "/delete-{id}-post" }, method = RequestMethod.GET)
	public String deletePost(@PathVariable int id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			postService.deletePostByID(id);
			return "redirect:/dashboard";
		}
		return "redirect:/login";
	}
	
	@RequestMapping(value = {"/edit-{post_id}-{reply_id}-reply"}, method = RequestMethod.GET)
	public String editReply(@PathVariable int post_id, @PathVariable int reply_id, ModelMap model) {
		if(model.containsAttribute("user_id")){ 
			model.addAttribute("editReply", replyService.findById(reply_id));
			replyService.setCurrentlyWorkingReply(replyService.findById(reply_id));
			replyService.setStatus(2);
			return "redirect:/detailedPost";
		}
		return "redirect:/login";
	}

	@RequestMapping(value = { "/delete-{post_id}-{reply_id}-reply" }, method = RequestMethod.GET)
	public String deleteReply(@PathVariable int post_id, @PathVariable int reply_id, ModelMap model) {
		if (model.containsAttribute("user_id")) {
			replyService.deleteReplyByID(reply_id);
			return "redirect:/detailedPost";
		}
		return "redirect:/login";
	}
	
	@RequestMapping(value= { "/reply-{post_id}-{reply_id}-{reply_depth}-reply"}, method = RequestMethod.GET)
	public String recursiveReply(@PathVariable int post_id, @PathVariable int reply_id, @PathVariable int reply_depth, ModelMap model){
		if(model.containsAttribute("user_id")) {
			replyService.setCurrentlyWorkingReply(replyService.findById(reply_id));
			replyService.setStatus(1); // Reply
			return "redirect:/detailedPost";
		}
		return "redirect:/login";
	}
	
	@RequestMapping(value = {"/detailedPost"}, method = {RequestMethod.GET})
	public String redirectToDetailedPost(ModelMap model){
		if (model.containsAttribute("user_id")) {
			model.addAttribute("post", postService.getCurrentPost());
			model.addAttribute("replies", replyService.findSortedReplies(postService.getCurrentPostID()));
			model.addAttribute("reply", new Reply());
			model.addAttribute("recursiveReply", new Reply());
			model.addAttribute("editReply", new Reply());
			
			
			if(replyService.getStatus() == 1) { // Reply
				int newDepth = replyService.getCurrentlyWorkingReply().getDepth() + 1;
				model.addAttribute("recursiveReplyPressed", true);
				model.addAttribute("replyDepth", newDepth);
				model.addAttribute("clickedReplyID", replyService.getCurrentlyWorkingReply().getId());
				
				if(newDepth > replyService.getMaxDepth())
					replyService.setMaxDepth(newDepth);
			}
			if(replyService.getStatus() == 2) {// Edit
				model.addAttribute("editReplyPressed", true);
				model.addAttribute("clickedReplyID", replyService.getCurrentlyWorkingReply().getId());
			}
				

			return "detailedPost";
		}
		return "redirect:/login";
	}
	
	@RequestMapping(value = { "/detailedPost" }, method = RequestMethod.POST)
	public String saveReply(@Valid Reply reply, BindingResult result, ModelMap model){
		if (model.containsAttribute("user_id")) {
			
			if (result.hasErrors()) {
				return "detailedPost";
			}
			
			else if (replyService.getStatus() == 1 || replyService.getStatus() == 0)
				replyService.saveReply(reply);
			
			else if (replyService.getStatus() == 2)
				replyService.updateReply(reply);
			
			model.addAttribute("replies", replyService.findSortedReplies(reply.getPost_id()));
			model.addAttribute("post", postService.getCurrentPost());
			replyService.setCurrentlyWorkingReply(null);
			replyService.setStatus(0);
			return "detailedPost";
		}
		return "redirect:/login";

	}

}

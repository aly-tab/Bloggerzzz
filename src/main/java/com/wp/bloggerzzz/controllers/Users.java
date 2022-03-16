package com.wp.bloggerzzz.controllers;

import java.security.Principal;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wp.bloggerzzz.models.Content;
import com.wp.bloggerzzz.models.User;
import com.wp.bloggerzzz.services.AccountService;
import com.wp.bloggerzzz.services.UserService;
import com.wp.bloggerzzz.validator.UserValidator;


@Controller
public class Users {
    private UserService userService;
    
    private UserValidator userValidator;
    
    private AccountService accountService;
    
    public Users(UserService userService, UserValidator userValidator, AccountService accountService) {
        this.userService = userService;
        this.userValidator = userValidator;
        this.accountService = accountService;
    }
    
    
    
    @RequestMapping("/registration")
    public String registerForm(@Valid @ModelAttribute("user") User user) {
        return "registrationPage.jsp";
    }
    
    @PostMapping("/registration")
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {
        userValidator.validate(user, result);
        if (result.hasErrors()) {
            return "registrationPage.jsp";
        }
        userService.saveUserWithAdminRole(user);
        return "redirect:/login";
    }
    
    
    @RequestMapping("/login")
    public String login(@RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model) {
        if(error != null) {
            model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
        }
        if(logout != null) {
            model.addAttribute("logoutMessage", "Logout Successful!");
        }
        return "loginPage.jsp";
    }
    
    @RequestMapping("/admin")
    public String adminPage(Principal principal, Model model) {
        String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
        return "adminPage.jsp";
    }
    
    @RequestMapping(value = "/home")
    public String home(Principal principal, Model model, HttpSession session) {	
    		if (principal == null) {
    			return "redirect:/";
    		}
    	
    		String username = principal.getName();
    		model.addAttribute("currentUser", userService.findByUsername(username));
    		model.addAttribute("content", new Content());
    		User user = userService.findByUsername(username);
    		model.addAttribute("user", user);
		
    		session.setAttribute("user_id", user.getId());
		
		
    		List<Content> content = accountService.findContentsByUser(user);
    		Collections.reverse(content);
    		model.addAttribute("allContents", content);
        return "homePage.jsp";
    }
    
	@PostMapping("/createPost")
	public String createPost(@Valid @ModelAttribute("content") Content content, BindingResult result, RedirectAttributes redirectAttributes) {
		if(result.hasErrors()) {
			return "homePage.jsp";
		}
		accountService.createContent(content);
		redirectAttributes.addFlashAttribute("success", "Your post was successful!");
		return "redirect:/home";
	}
	
	@RequestMapping(value="/delete/{username}/{id}")
	public String deletePost(@PathVariable("username") String username, @PathVariable("id") Long id, HttpSession session) {
		User user = userService.findByUsername(username);
		if (session.getAttribute("user_id") != user.getId()) {
			return "redirect:/";
		}
		this.accountService.deleteContent(id);
		return "redirect:/" + username;
	}

	@RequestMapping(value="/editPost/{username}/{id}")
	public String editPost(@PathVariable("id") Long id, @PathVariable("username") String username, Model model, HttpSession session) {
		Long logId = (Long) session.getAttribute("user_id");
		User loggedIn = userService.findById(logId);
		User user = userService.findByUsername(username);
		
		if (loggedIn.getUsername() != user.getUsername()) {
			return "redirect:/";
		}
		
		model.addAttribute("user", user);
		Content content = accountService.findContentById(id);
		model.addAttribute("content", content);
		return "editPost.jsp";
	}
	
    @RequestMapping(value="/{username}")
    public String profile(Principal principal, HttpSession session, Model model, @PathVariable("username") String username) {
    	if (session.getAttribute("user_id") != null) {
    		Long id = (Long) session.getAttribute("user_id");
    		User loggedIn = userService.findById(id);
    		model.addAttribute("loggedIn", loggedIn);
    	}
    	
		model.addAttribute("content", new Content());
		User user = userService.findByUsername(username);
		model.addAttribute("user", user);
		List<Content> content = accountService.findContentsByUser(user);
		Collections.reverse(content);
		model.addAttribute("allContents", content);
    	return "profile.jsp";
    }
    
	@PostMapping("/updatePost/{username}/{id}")
	public String updateContent( @PathVariable("username") String username, @PathVariable("id") Long id, @Valid @ModelAttribute("content") Content content, BindingResult result, RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return "editPost.jsp";
		}
		accountService.updateContent(content);
		redirectAttributes.addFlashAttribute("success", "Your post update was successful!");
		return "redirect:/editPost/" + username + "/" + id;
	}
	
	@RequestMapping("/view")
	public String view(Principal principal, Model model, HttpSession session) {
    	if (session.getAttribute("user_id") != null) {
    		String username = principal.getName();
    		model.addAttribute("username", username);
    		
        	Long id = (Long) session.getAttribute("user_id");
        	User loggedIn = userService.findById(id);
        	model.addAttribute("loggedIn", loggedIn);
    	}
		List<User> users = userService.findAllUsers();
		users.sort((o1, o2) -> o1.getUsername().toLowerCase().compareTo(o2.getUsername().toLowerCase()));
		model.addAttribute("users", users);
		return "view.jsp";
	}	
	
	@RequestMapping("/")
	public String welcome() {
		return "welcome.jsp";
	}
	
	@RequestMapping("/postView/{username}/{id}")
	public String postView(@PathVariable("username") String username, @PathVariable("id") Long id, Model model, HttpSession session) {
    	if (session.getAttribute("user_id") != null) {
    		Long idL = (Long) session.getAttribute("user_id");
    		User loggedIn = userService.findById(idL);
    		model.addAttribute("loggedIn", loggedIn);
    	}
    	
		User user = userService.findByUsername(username);
		model.addAttribute("user", user);
		
		Content content = accountService.findContentById(id);
		model.addAttribute("content", content);
		return "viewPost.jsp";
	}
	
	@RequestMapping("/account/{username}/{id}")
	public String account(@PathVariable("id") Long id,  @PathVariable("username") String username, Principal principal, Model model, HttpSession session) {
		Long logId = (Long) session.getAttribute("user_id");
		User loggedIn = userService.findById(logId);
		User user = userService.findByUsername(username);
		
		if (loggedIn.getUsername() != user.getUsername()) {
			return "redirect:/";
		}
		
		model.addAttribute("user", loggedIn);
		return "Account.jsp";
	}
	
	@RequestMapping("/deleteUserAccount")
	public String deleteUser(HttpSession session) {
    	if (session.getAttribute("user_id") == null) {
    		return "redirect:/";
    	}
		Long id = (Long) session.getAttribute("user_id");
		User user = userService.findById(id);
		this.accountService.deleteContentByUser(user);
		this.userService.deleteUser(id);
		session.invalidate();
		return "redirect:/";
	}
	
}

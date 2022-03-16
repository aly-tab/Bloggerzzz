package com.wp.bloggerzzz.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.wp.bloggerzzz.models.User;
import com.wp.bloggerzzz.services.UserService;
@Component
public class UserValidator implements Validator {
	private UserService userService;
	
    public UserValidator(UserService userService) {
        this.userService = userService;
    }
    
    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }
    
    
	@Override
    public void validate(Object object, Errors errors) {
        User user = (User) object;
        
        User returnUser = userService.findByUsername(user.getUsername());
        
        if (returnUser != null) {
            errors.rejectValue("username", "", "Username must be unique");
        }
        
        if (!user.getPasswordConfirmation().equals(user.getPassword())) {
            errors.rejectValue("passwordConfirmation", "", "Passwords must match");
        }         
    }
}

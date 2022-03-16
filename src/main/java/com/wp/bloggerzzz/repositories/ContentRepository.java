package com.wp.bloggerzzz.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.wp.bloggerzzz.models.Content;
import com.wp.bloggerzzz.models.User;

public interface ContentRepository extends CrudRepository<Content, Long>{
	List<Content> findAllByUser(User user);

	void deleteAllByUser(User user);
}

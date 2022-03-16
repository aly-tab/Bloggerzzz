package com.wp.bloggerzzz.services;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.wp.bloggerzzz.models.Content;
import com.wp.bloggerzzz.models.User;
import com.wp.bloggerzzz.repositories.ContentRepository;


@Service
public class AccountService {
	private final ContentRepository contentRepository;
	
	public AccountService(ContentRepository contentRepository) {
		this.contentRepository = contentRepository;
	}
	public Content createContent(Content c) {
		return contentRepository.save(c);
	}
	
	public Content updateContent(Content c) {
		return contentRepository.save(c);
	}
	
	public void deleteContent(long id) {
		this.contentRepository.deleteById(id);
	}
	
	public List<Content> findContentsByUser(User u) {
		return contentRepository.findAllByUser(u);
	}
	
	public Content findContentById(Long id) {
		Optional<Content> optionalContent = this.contentRepository.findById(id);
		if(optionalContent.isPresent()) {
			return optionalContent.get();
		} else {
			return null;
		}
	}
	
	@Transactional
	public void deleteContentByUser(User u) {
		this.contentRepository.deleteAllByUser(u);
	}
}

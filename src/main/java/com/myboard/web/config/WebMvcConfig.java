package com.myboard.web.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.myboard.web.board.interceptor.SessionInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	
	@Value("{resources.image.uri_path}")
	private String imgUriPath;
	@Value("${resources.image.location}")
	private String imgLocation;
	@Value("${resources.file.uri_path}")
	private String fileUriPath;
	@Value("${resources.file.location}")
	private String fileLocation;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(imgUriPath+"/**")
		.addResourceLocations("file://"+imgLocation)
		.setCachePeriod(20);
		
		registry.addResourceHandler(fileUriPath+"/**")
		.addResourceLocations("file://"+fileLocation)
		.setCachePeriod(30);
		
		registry.addResourceHandler("/icon/**").addResourceLocations("classpath:/static/icon/");
	}

	@Autowired
	SessionInterceptor sessionInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(sessionInterceptor)
				.addPathPatterns(sessionInterceptor.NEEDSESSION);
		
	}
	
	
	
}

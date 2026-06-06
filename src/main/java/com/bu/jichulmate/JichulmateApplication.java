package com.bu.jichulmate;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class JichulmateApplication {
	public static void main(String[] args) {
		SpringApplication.run(JichulmateApplication.class, args);
	}
}

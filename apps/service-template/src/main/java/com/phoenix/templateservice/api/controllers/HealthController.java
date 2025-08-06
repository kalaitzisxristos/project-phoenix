package com.phoenix.templateservice.api.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.Map;

/**
 * A simple controller to provide a health check endpoint.
 * This is useful for confirming that the service is running and responsive.
 */
@RestController
@RequestMapping("/api/v1/health")
public class HealthController {

    /**
     * Returns a simple JSON object indicating the service status.
     * @return A map with a "status" key and "UP" value.
     */
    @GetMapping
    public Map<String, String> getHealthStatus() {
        return Collections.singletonMap("status", "UP");
    }
}